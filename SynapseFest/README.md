# SYNAPSE Fest iOS App

An iOS application for the SYNAPSE Intercollege Fest at MAMC (Maulana Azad Medical College), Delhi. This app provides comprehensive information about all fest events, including detailed descriptions, schedules, venues, and registration links.

## Features

### 🎯 Core Functionality
- **Event Listing**: Browse all SYNAPSE fest events in an organized, categorized view
- **Category Filtering**: Filter events by category (Cultural, Technical, Sports, Literary, Arts, Medical Quiz)
- **Detailed Event Information**: View complete event details including:
  - Event description and rules
  - Date, time, and venue
  - Prize pool and team size requirements
  - Contact information
  - Registration links
- **Direct Registration**: One-tap access to event registration forms
- **Professional UI**: Modern, intuitive interface with category-based color coding

### 🎨 Event Categories
- **Cultural**: Music, dance, and performance arts
- **Technical**: Hackathons and tech competitions
- **Sports**: Inter-college sports tournaments
- **Literary**: Debates, poetry, and creative writing
- **Arts & Crafts**: Photography and visual arts
- **Medical Quiz**: Medical knowledge competitions

## Architecture

The app follows modern iOS development best practices:

- **SwiftUI**: Declarative UI framework for building the interface
- **MVVM Pattern**: Clean separation of data, business logic, and UI
- **ObservableObject**: Reactive data management
- **Navigation**: SwiftUI NavigationView for seamless navigation

### Project Structure
```
SynapseFest/
├── SynapseFest.xcodeproj/     # Xcode project file
└── SynapseFest/                # Source code
    ├── SynapseFestApp.swift    # App entry point
    ├── ContentView.swift       # Main view with fest branding
    ├── Models/
    │   └── EventModel.swift    # Event data model
    ├── Views/
    │   ├── EventListView.swift # Events list with filtering
    │   └── EventDetailView.swift # Detailed event view
    ├── Services/
    │   └── EventDataService.swift # Data management service
    └── Assets.xcassets/        # App icons and colors
```

## Sample Events

The app includes 8 comprehensive sample events:

1. **Battle of Bands** (Cultural) - Musical competition with ₹50,000 prize pool
2. **Hackathon 2024** (Technical) - 24-hour healthcare innovation challenge
3. **Medical Quiz Competition** (Medical) - Test medical knowledge
4. **Street Dance Championship** (Cultural) - Hip-hop and street dance
5. **Debate Competition** (Literary) - Healthcare and social topics
6. **Photography Exhibition** (Arts) - Theme: Healthcare & Humanity
7. **Football Tournament** (Sports) - Inter-college football
8. **Poetry Slam** (Literary) - Original poetry performances

## Requirements

- **iOS**: 15.0 or later
- **Xcode**: 14.0 or later
- **Swift**: 5.0 or later
- **Device**: iPhone or iPad

## Installation & Setup

### Option 1: Build with Xcode (Recommended)

1. **Prerequisites**:
   - macOS with Xcode installed
   - Apple Developer account (for device testing)

2. **Steps**:
   ```bash
   # Navigate to the project directory
   cd SynapseFest
   
   # Open the project in Xcode
   open SynapseFest.xcodeproj
   ```

3. **In Xcode**:
   - Select your target device (iPhone simulator or physical device)
   - Press `Cmd + R` or click the Run button
   - The app will build and launch

### Option 2: Command Line Build

```bash
# Build for simulator (x86_64)
xcodebuild -project SynapseFest.xcodeproj \
  -scheme SynapseFest \
  -sdk iphonesimulator \
  -configuration Debug build

# Build for device (arm64) - requires Apple Developer account
xcodebuild -project SynapseFest.xcodeproj \
  -scheme SynapseFest \
  -sdk iphoneos \
  -configuration Release build
```

## Usage

### Running on Simulator
1. Open Xcode
2. Select an iPhone simulator from the device menu
3. Press `Cmd + R` to build and run
4. The app will launch in the iOS Simulator

### Running on Physical Device
1. Connect your iPhone/iPad via USB
2. Select your device from the device menu in Xcode
3. Ensure your device is trusted and developer mode is enabled
4. Press `Cmd + R` to build and install
5. If prompted, trust the developer certificate in Settings > General > VPN & Device Management

## App Navigation

1. **Home Screen**: 
   - Displays SYNAPSE fest branding
   - Shows welcome message and tagline
   - Leads to event list

2. **Event List**:
   - Horizontal category filter buttons
   - Scrollable list of event cards
   - Each card shows key info: name, category, date, time, venue
   - Tap any event to view details

3. **Event Detail**:
   - Full event information
   - Complete description and rules
   - Contact information
   - "Register Now" button linking to registration form

## Azure Integration (Future Enhancement)

The app is designed with Azure backend integration in mind:

### Planned Azure Services
- **Azure Functions**: Serverless API endpoints for event data
- **Azure Cosmos DB**: NoSQL database for event storage
- **Azure App Service**: REST API hosting
- **Azure Blob Storage**: Media and document storage
- **Azure Notification Hub**: Push notifications for event updates

### Implementation Approach
```swift
// EventDataService.swift includes placeholder methods:
func fetchEventsFromAzure() {
    // Fetch real-time event data from Azure backend
}

func submitRegistration(eventId: UUID, participantData: [String: Any]) {
    // Submit registration to Azure backend
}
```

To enable Azure integration:
1. Set up Azure resources (Functions, Cosmos DB, etc.)
2. Configure API endpoints in the app
3. Implement network layer with URLSession or Alamofire
4. Add authentication if needed (Azure AD B2C)
5. Handle offline mode with local caching

## Customization

### Adding New Events
Edit `EventDataService.swift` and add events to the `loadEvents()` method:

```swift
Event(
    name: "Your Event Name",
    category: .cultural,  // or .technical, .sports, etc.
    description: "Short description",
    detailedDescription: "Full description with all details",
    date: "Date",
    time: "Time",
    venue: "Venue Name",
    registrationLink: "https://registration-link",
    prizePool: "Prize amount",
    teamSize: "Team size",
    contactPerson: "Contact name",
    contactEmail: "email@example.com",
    rules: ["Rule 1", "Rule 2", "..."]
)
```

### Changing Colors
Modify color schemes in the view files:
- `ContentView.swift`: Header gradient
- `EventListView.swift`: Category colors
- `EventDetailView.swift`: Detail view colors

### Updating Branding
- Replace app icon in `Assets.xcassets/AppIcon.appiconset`
- Update fest name and tagline in `ContentView.swift`
- Modify accent color in `Assets.xcassets/AccentColor.colorset`

## Testing

### Manual Testing Checklist
- [ ] App launches successfully
- [ ] All events display in the list
- [ ] Category filtering works correctly
- [ ] Event detail view shows all information
- [ ] Registration links open in Safari
- [ ] UI renders correctly on different iPhone models
- [ ] Navigation works smoothly (back/forward)
- [ ] Text is readable and properly formatted

### Simulator Testing
Test on multiple simulator devices:
- iPhone SE (small screen)
- iPhone 14 (standard size)
- iPhone 14 Pro Max (large screen)
- iPad (tablet layout)

## Troubleshooting

### Common Issues

**Build Fails**:
- Ensure Xcode is up to date (14.0+)
- Clean build folder: `Cmd + Shift + K`
- Restart Xcode

**App Crashes on Launch**:
- Check console logs in Xcode
- Verify all Swift files compile without errors
- Ensure asset catalog is properly configured

**Registration Links Don't Open**:
- Verify URL strings are valid
- Check that `LSApplicationQueriesSchemes` includes required URL schemes
- Test URLs in Safari first

**UI Layout Issues**:
- Check device orientation (portrait vs. landscape)
- Verify SwiftUI preview providers
- Test on different screen sizes

## Contributing

To contribute to this app:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly on simulator and device
5. Submit a pull request with description of changes

## License

This project is created for the SYNAPSE fest at MAMC Delhi. 

## Contact

For questions or support regarding the app:

- **Technical Issues**: tech@synapsemamc.in
- **Event Information**: info@synapsemamc.in
- **SYNAPSE Fest**: www.synapsemamc.in (example)

## Acknowledgments

- MAMC Delhi for hosting SYNAPSE fest
- All event coordinators and organizers
- iOS development community for SwiftUI resources

---

**Built with ❤️ for SYNAPSE - MAMC Delhi**

*Connecting Minds, Creating Memories*
