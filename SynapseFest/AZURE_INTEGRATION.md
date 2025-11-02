# Azure Integration Guide for SYNAPSE Fest iOS App

This guide provides detailed instructions for integrating Azure cloud services with the SYNAPSE Fest iOS app to enable dynamic event management, user registration, and real-time updates.

## Overview

The iOS app currently uses local data stored in `EventDataService.swift`. This guide shows how to integrate Azure services to enable:

- **Dynamic event management** via Azure backend
- **User registration** and data storage
- **Real-time updates** and notifications
- **Analytics** and insights
- **Media storage** for event photos/videos

## Recommended Azure Architecture

### Core Services

1. **Azure Functions** (Serverless APIs)
   - Event CRUD operations
   - Registration handling
   - Data validation
   
2. **Azure Cosmos DB** (NoSQL Database)
   - Event data storage
   - User registration records
   - Analytics data

3. **Azure Blob Storage** (Media Storage)
   - Event images
   - Promotional materials
   - User-uploaded content

4. **Azure Notification Hub** (Push Notifications)
   - Event reminders
   - Update notifications
   - Registration confirmations

5. **Azure App Service** (Optional REST API)
   - Alternative to Azure Functions
   - Full REST API hosting

## Step-by-Step Implementation

### Phase 1: Setup Azure Resources

#### 1.1 Create Azure Account
```bash
# Install Azure CLI
brew install azure-cli

# Login to Azure
az login

# Create resource group
az group create --name synapse-fest-rg --location eastus
```

#### 1.2 Setup Cosmos DB
```bash
# Create Cosmos DB account
az cosmosdb create \
  --name synapse-fest-db \
  --resource-group synapse-fest-rg \
  --locations regionName=eastus

# Create database
az cosmosdb sql database create \
  --account-name synapse-fest-db \
  --resource-group synapse-fest-rg \
  --name SynapseFestDB

# Create containers
az cosmosdb sql container create \
  --account-name synapse-fest-db \
  --database-name SynapseFestDB \
  --name Events \
  --partition-key-path "/category" \
  --resource-group synapse-fest-rg

az cosmosdb sql container create \
  --account-name synapse-fest-db \
  --database-name SynapseFestDB \
  --name Registrations \
  --partition-key-path "/eventId" \
  --resource-group synapse-fest-rg
```

#### 1.3 Setup Azure Functions
```bash
# Create Function App
az functionapp create \
  --name synapse-fest-api \
  --resource-group synapse-fest-rg \
  --consumption-plan-location eastus \
  --runtime node \
  --runtime-version 18 \
  --functions-version 4 \
  --storage-account synapsefeststorage

# Or use Python
az functionapp create \
  --name synapse-fest-api \
  --resource-group synapse-fest-rg \
  --consumption-plan-location eastus \
  --runtime python \
  --runtime-version 3.9 \
  --functions-version 4 \
  --storage-account synapsefeststorage
```

#### 1.4 Setup Blob Storage
```bash
# Create storage account
az storage account create \
  --name synapsefeststorage \
  --resource-group synapse-fest-rg \
  --location eastus \
  --sku Standard_LRS

# Create containers
az storage container create \
  --name event-images \
  --account-name synapsefeststorage

az storage container create \
  --name promotional-media \
  --account-name synapsefeststorage
```

### Phase 2: Implement Azure Functions

#### 2.1 Function: Get All Events

**JavaScript (Node.js)**
```javascript
// GetEvents/index.js
const { CosmosClient } = require("@azure/cosmos");

module.exports = async function (context, req) {
    const endpoint = process.env.COSMOS_ENDPOINT;
    const key = process.env.COSMOS_KEY;
    
    const client = new CosmosClient({ endpoint, key });
    const database = client.database("SynapseFestDB");
    const container = database.container("Events");
    
    try {
        const { resources: events } = await container.items
            .query("SELECT * FROM c")
            .fetchAll();
            
        context.res = {
            status: 200,
            body: events,
            headers: { "Content-Type": "application/json" }
        };
    } catch (error) {
        context.res = {
            status: 500,
            body: { error: error.message }
        };
    }
};
```

**Python**
```python
# GetEvents/__init__.py
import azure.functions as func
from azure.cosmos import CosmosClient
import os
import json

def main(req: func.HttpRequest) -> func.HttpResponse:
    endpoint = os.environ['COSMOS_ENDPOINT']
    key = os.environ['COSMOS_KEY']
    
    client = CosmosClient(endpoint, key)
    database = client.get_database_client("SynapseFestDB")
    container = database.get_container_client("Events")
    
    try:
        events = list(container.query_items(
            query="SELECT * FROM c",
            enable_cross_partition_query=True
        ))
        
        return func.HttpResponse(
            json.dumps(events),
            mimetype="application/json",
            status_code=200
        )
    except Exception as e:
        return func.HttpResponse(
            json.dumps({"error": str(e)}),
            mimetype="application/json",
            status_code=500
        )
```

#### 2.2 Function: Submit Registration

```javascript
// SubmitRegistration/index.js
const { CosmosClient } = require("@azure/cosmos");
const { v4: uuidv4 } = require('uuid');

module.exports = async function (context, req) {
    const endpoint = process.env.COSMOS_ENDPOINT;
    const key = process.env.COSMOS_KEY;
    
    const client = new CosmosClient({ endpoint, key });
    const database = client.database("SynapseFestDB");
    const container = database.container("Registrations");
    
    if (!req.body || !req.body.eventId || !req.body.participantData) {
        context.res = {
            status: 400,
            body: { error: "Missing required fields" }
        };
        return;
    }
    
    const registration = {
        id: uuidv4(),
        eventId: req.body.eventId,
        participantData: req.body.participantData,
        timestamp: new Date().toISOString(),
        status: "pending"
    };
    
    try {
        const { resource: createdItem } = await container.items.create(registration);
        
        context.res = {
            status: 201,
            body: {
                success: true,
                registrationId: createdItem.id,
                message: "Registration submitted successfully"
            }
        };
    } catch (error) {
        context.res = {
            status: 500,
            body: { error: error.message }
        };
    }
};
```

### Phase 3: Update iOS App

#### 3.1 Create Network Manager

```swift
// NetworkManager.swift
import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://synapse-fest-api.azurewebsites.net/api"
    
    private init() {}
    
    func fetchEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/GetEvents") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let events = try JSONDecoder().decode([Event].self, from: data)
                completion(.success(events))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func submitRegistration(eventId: UUID, participantData: [String: Any], 
                          completion: @escaping (Result<RegistrationResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/SubmitRegistration") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "eventId": eventId.uuidString,
            "participantData": participantData
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(RegistrationResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct RegistrationResponse: Codable {
    let success: Bool
    let registrationId: String
    let message: String
}
```

#### 3.2 Update EventDataService

```swift
// EventDataService.swift - Azure Integration
import Foundation

class EventDataService: ObservableObject {
    @Published var events: [Event] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init() {
        fetchEventsFromAzure()
    }
    
    func fetchEventsFromAzure() {
        isLoading = true
        errorMessage = nil
        
        NetworkManager.shared.fetchEvents { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let events):
                    self?.events = events
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    // Fallback to local data
                    self?.loadLocalEvents()
                }
            }
        }
    }
    
    private func loadLocalEvents() {
        // Keep existing local data as fallback
        // ... existing implementation ...
    }
    
    func submitRegistration(eventId: UUID, participantData: [String: Any], 
                          completion: @escaping (Result<RegistrationResponse, Error>) -> Void) {
        NetworkManager.shared.submitRegistration(eventId: eventId, 
                                                 participantData: participantData,
                                                 completion: completion)
    }
}
```

### Phase 4: Add Push Notifications

#### 4.1 Setup Notification Hub

```bash
# Create Notification Hub namespace
az notification-hub namespace create \
  --resource-group synapse-fest-rg \
  --name synapse-fest-notifications \
  --location eastus \
  --sku Free

# Create Notification Hub
az notification-hub create \
  --resource-group synapse-fest-rg \
  --namespace-name synapse-fest-notifications \
  --name synapse-fest-hub \
  --location eastus
```

#### 4.2 iOS App Setup

Add to `Info.plist`:
```xml
<key>UIBackgroundModes</key>
<array>
    <string>remote-notification</string>
</array>
```

Update `SynapseFestApp.swift`:
```swift
import SwiftUI
import UserNotifications

@main
struct SynapseFestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, 
                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
        }
        
        return true
    }
    
    func application(_ application: UIApplication, 
                    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        // Send token to Azure Notification Hub
        print("Device Token: \(token)")
    }
}
```

### Phase 5: Analytics Integration

#### 5.1 Azure Application Insights

```bash
# Create Application Insights resource
az monitor app-insights component create \
  --app synapse-fest-insights \
  --location eastus \
  --resource-group synapse-fest-rg
```

#### 5.2 iOS Integration

Add to your Swift code:
```swift
import ApplicationInsights

class AnalyticsManager {
    static let shared = AnalyticsManager()
    
    func trackEvent(name: String, properties: [String: String]? = nil) {
        // Track custom events
        // Example: User viewed event detail, registered for event, etc.
    }
    
    func trackPageView(name: String) {
        // Track page/screen views
    }
}
```

## Security Considerations

### 1. API Authentication

Implement Azure AD B2C or API keys:

```swift
class NetworkManager {
    private let apiKey = "YOUR_API_KEY"
    
    func makeAuthenticatedRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
        return request
    }
}
```

### 2. Data Validation

Always validate data on both client and server:

```javascript
// Azure Function validation
function validateRegistration(data) {
    if (!data.eventId || !data.participantData) {
        throw new Error("Missing required fields");
    }
    
    if (!isValidEmail(data.participantData.email)) {
        throw new Error("Invalid email format");
    }
    
    return true;
}
```

### 3. CORS Configuration

Configure CORS in Azure Functions:

```json
{
  "cors": {
    "allowedOrigins": [
      "*"
    ]
  }
}
```

## Cost Estimation

For a small to medium fest:

| Service | Tier | Monthly Cost |
|---------|------|--------------|
| Azure Functions | Consumption | $0-5 |
| Cosmos DB | Serverless | $5-25 |
| Blob Storage | Standard | $1-5 |
| Notification Hub | Free | $0 |
| **Total** | | **$6-35** |

## Deployment Checklist

- [ ] Create Azure account and resource group
- [ ] Setup Cosmos DB with Events and Registrations containers
- [ ] Deploy Azure Functions for API endpoints
- [ ] Configure Blob Storage for media
- [ ] Setup Notification Hub for push notifications
- [ ] Update iOS app with network layer
- [ ] Test API endpoints
- [ ] Implement error handling and offline mode
- [ ] Add authentication if needed
- [ ] Configure monitoring and logging
- [ ] Test push notifications
- [ ] Deploy to App Store

## Testing

### Local Testing
```bash
# Install Azure Functions Core Tools
npm install -g azure-functions-core-tools@4

# Run functions locally
cd azure-functions
func start
```

### iOS Testing with Local Functions
Update base URL in NetworkManager:
```swift
private let baseURL = "http://localhost:7071/api"  // Local testing
```

## Monitoring and Maintenance

1. **Application Insights Dashboard**: Monitor API usage, errors, performance
2. **Cosmos DB Metrics**: Track RU/s consumption, storage
3. **Function App Metrics**: Monitor execution count, failures
4. **Notification Hub**: Track push notification delivery

## Support and Resources

- [Azure Functions Documentation](https://docs.microsoft.com/azure/azure-functions/)
- [Cosmos DB Documentation](https://docs.microsoft.com/azure/cosmos-db/)
- [Azure Notification Hubs iOS Guide](https://docs.microsoft.com/azure/notification-hubs/ios-sdk-get-started)
- [Azure CLI Reference](https://docs.microsoft.com/cli/azure/)

---

**For questions or assistance with Azure integration, contact: tech@synapsemamc.in**
