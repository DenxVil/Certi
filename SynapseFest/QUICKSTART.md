# SYNAPSE Fest iOS App - Quick Start Guide

## 🚀 Quick Start (5 Minutes)

### Prerequisites
- macOS computer
- Xcode 14.0 or later installed
- Basic familiarity with Xcode

### Step 1: Open Project
```bash
cd SynapseFest
open SynapseFest.xcodeproj
```

### Step 2: Select Simulator
In Xcode:
1. Click the device dropdown (top-left)
2. Select "iPhone 14 Pro" or any simulator

### Step 3: Run
1. Press `Cmd + R` or click the Play button
2. Wait for build to complete (30-60 seconds first time)
3. App launches in simulator!

## 📱 App Navigation Flow

```
┌─────────────────────────────────────────┐
│         SYNAPSE Home Screen             │
│  ┌───────────────────────────────────┐  │
│  │     ⭐ SYNAPSE Logo & Branding    │  │
│  │   "MAMC Delhi Intercollege Fest"  │  │
│  │  "Connecting Minds, Creating..."  │  │
│  └───────────────────────────────────┘  │
└─────────────────┬───────────────────────┘
                  │
                  ▼
┌─────────────────────────────────────────┐
│         Event List View                 │
│  ┌───────────────────────────────────┐  │
│  │  [All] [Cultural] [Technical]...  │  │ ← Category Filter
│  └───────────────────────────────────┘  │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │ 🎵 Battle of Bands                │  │
│  │ Cultural | 15th March | 2:00 PM   │  │ ← Event Card
│  │ MAMC Main Auditorium              │  │
│  └───────────────────────────────────┘  │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │ 💻 Hackathon 2024                 │  │
│  │ Technical | 16-17 March           │  │
│  └───────────────────────────────────┘  │
└─────────────────┬───────────────────────┘
                  │ Tap Event
                  ▼
┌─────────────────────────────────────────┐
│       Event Detail View                 │
│  ┌───────────────────────────────────┐  │
│  │      Battle of Bands Header       │  │ ← Gradient Header
│  └───────────────────────────────────┘  │
│                                         │
│  📅 Date: 15th March 2024              │
│  ⏰ Time: 2:00 PM - 6:00 PM            │
│  📍 Venue: MAMC Main Auditorium        │
│  👥 Team Size: 3-6 members             │
│  🏆 Prize Pool: ₹50,000                │
│                                         │
│  About:                                 │
│  "SYNAPSE presents the ultimate..."     │
│                                         │
│  Rules & Guidelines:                    │
│  1. Band must consist of 3-6 members   │
│  2. Performance time limit: 15 mins    │
│  ...                                    │
│                                         │
│  Contact:                               │
│  👤 Rahul Sharma                        │
│  ✉️ cultural@synapsemamc.in            │
│                                         │
│  ┌───────────────────────────────────┐  │
│  │     🔗 Register Now →             │  │ ← Opens Safari
│  └───────────────────────────────────┘  │
└─────────────────────────────────────────┘
```

## 🏗️ App Architecture

```
┌─────────────────────────────────────────────────────────┐
│                   SynapseFestApp                        │
│                  (Entry Point)                          │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│                  ContentView                            │
│           (Main View with Branding)                     │
│  ┌─────────────────────────────────────────────────┐   │
│  │         EventDataService (@StateObject)         │   │
│  │      • Published var events: [Event]            │   │
│  │      • loadEvents()                             │   │
│  │      • fetchEventsFromAzure() [placeholder]     │   │
│  └─────────────────────────────────────────────────┘   │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│                EventListView                            │
│         (Events List + Filtering)                       │
│                                                         │
│  Components:                                            │
│  • CategoryButton (filter buttons)                     │
│  • EventCardView (event cards)                         │
│  • filteredEvents computed property                    │
│                                                         │
│  Navigation: NavigationLink → EventDetailView          │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│              EventDetailView                            │
│          (Full Event Information)                       │
│                                                         │
│  Components:                                            │
│  • InfoRow (quick info rows)                           │
│  • SectionView (reusable sections)                     │
│  • Registration button with openURL                    │
│                                                         │
│  Data: Event model passed via navigation               │
└─────────────────────────────────────────────────────────┘
```

## 📊 Data Models

```swift
// Event Model Structure
Event {
    id: UUID
    name: String
    category: EventCategory
    description: String
    detailedDescription: String
    date: String
    time: String
    venue: String
    registrationLink: String
    prizePool: String?
    teamSize: String?
    contactPerson: String?
    contactEmail: String?
    rules: [String]
}

// Event Categories
EventCategory: Enum {
    .cultural    → 🎵 Orange
    .technical   → 💻 Blue
    .sports      → ⚽ Green
    .literary    → 📚 Purple
    .arts        → 🎨 Pink
    .medical     → ⚕️ Red
}
```

## 🎨 Design System

### Colors
- **Primary**: Blue (for general actions)
- **Category Colors**:
  - Cultural: Orange
  - Technical: Blue
  - Sports: Green
  - Literary: Purple
  - Arts: Pink
  - Medical: Red
- **Backgrounds**: 
  - Cards: White/System Background
  - Filters: System Gray 6
  - Gradients: Category color variations

### Typography
- **Headers**: System Bold, 32-42pt
- **Titles**: System Bold, 20pt
- **Body**: System Regular, 15-16pt
- **Captions**: System Medium, 13-14pt

### Spacing
- Card padding: 16pt
- Section spacing: 20pt
- Element spacing: 8-12pt
- Corner radius: 12-16pt

## 📝 Sample Events Included

| # | Event Name | Category | Prize Pool |
|---|------------|----------|------------|
| 1 | Battle of Bands | Cultural | ₹50,000 |
| 2 | Hackathon 2024 | Technical | ₹1,00,000 |
| 3 | Medical Quiz | Medical | ₹30,000 |
| 4 | Street Dance | Cultural | ₹40,000 |
| 5 | Debate Competition | Literary | ₹20,000 |
| 6 | Photography Exhibition | Arts | ₹15,000 |
| 7 | Football Tournament | Sports | ₹35,000 |
| 8 | Poetry Slam | Literary | ₹18,000 |

## 🔧 Customization Guide

### Adding a New Event

1. Open `EventDataService.swift`
2. Find the `loadEvents()` method
3. Add new event:

```swift
Event(
    name: "Your Event Name",
    category: .cultural,  // Choose category
    description: "Brief description",
    detailedDescription: "Full description with all details",
    date: "20th March 2024",
    time: "3:00 PM - 6:00 PM",
    venue: "Your Venue",
    registrationLink: "https://forms.gle/your-link",
    prizePool: "₹25,000",
    teamSize: "2-4 members",
    contactPerson: "Contact Name",
    contactEmail: "email@example.com",
    rules: [
        "Rule 1",
        "Rule 2",
        "Rule 3"
    ]
)
```

### Changing Fest Name

Edit `ContentView.swift`:
```swift
Text("SYNAPSE")  // Change to your fest name
    .font(.system(size: 42, weight: .bold, design: .rounded))

Text("MAMC Delhi Intercollege Fest")  // Change tagline
    .font(.system(size: 16, weight: .medium))
```

### Updating Colors

Edit category colors in `EventListView.swift`:
```swift
var categoryColor: Color {
    switch event.category {
    case .cultural: return .orange  // Change colors here
    case .technical: return .blue
    // ... etc
    }
}
```

## 🧪 Testing Checklist

### Functional Tests
- [ ] App launches without crashes
- [ ] All 8 events display correctly
- [ ] Category filtering works (All, Cultural, Technical, etc.)
- [ ] Tapping event navigates to detail view
- [ ] Back navigation works
- [ ] All event details display correctly
- [ ] Registration link opens Safari
- [ ] ScrollView scrolls smoothly

### UI Tests (Different Devices)
- [ ] iPhone SE (small screen) - text readable, no overflow
- [ ] iPhone 14 (standard) - optimal layout
- [ ] iPhone 14 Pro Max (large) - good use of space
- [ ] iPad - adaptive layout

### Edge Cases
- [ ] Long event names display properly
- [ ] Long descriptions don't overflow
- [ ] Multiple rules display correctly
- [ ] Events without optional fields (prizePool, teamSize) display correctly

## 🚨 Troubleshooting

### Build Errors

**"Cannot find 'SynapseFestApp' in scope"**
- Solution: Clean build folder (`Cmd + Shift + K`) and rebuild

**"Developer cannot be verified"** (on device)
- Solution: Settings → General → VPN & Device Management → Trust developer

**Simulator doesn't launch**
- Solution: Restart Xcode, or reset simulator via Device menu

### Runtime Issues

**App crashes on launch**
- Check: Console logs in Xcode (bottom panel)
- Common cause: Missing asset or file reference

**Events don't display**
- Check: EventDataService initialization in ContentView
- Verify: Sample data in loadEvents() method

**Registration link doesn't open**
- Check: URL string is valid (starts with http:// or https://)
- Verify: iOS simulator has internet connectivity

## 📚 Next Steps

1. **Run the app** following Quick Start guide
2. **Customize events** for your specific fest
3. **Test thoroughly** on multiple simulators
4. **Optionally integrate Azure** using AZURE_INTEGRATION.md guide
5. **Deploy to TestFlight** for beta testing
6. **Submit to App Store** when ready

## 🔗 Important Files Reference

| File | Purpose |
|------|---------|
| `SynapseFestApp.swift` | App entry point |
| `ContentView.swift` | Home screen with branding |
| `EventModel.swift` | Event data structure |
| `EventDataService.swift` | Data management (add events here) |
| `EventListView.swift` | Events list with filtering |
| `EventDetailView.swift` | Detailed event view |
| `README.md` | Full documentation |
| `AZURE_INTEGRATION.md` | Cloud backend guide |

## 💡 Pro Tips

1. **Use SwiftUI Preview**: Add preview providers to see changes instantly
2. **Test on real device**: Simulator doesn't show true performance
3. **Offline first**: App works without internet (local data)
4. **Color coding**: Category colors help users navigate quickly
5. **Registration links**: Keep them short and test before publishing

## 📞 Support

Need help? Check these resources:
- **README.md**: Comprehensive documentation
- **AZURE_INTEGRATION.md**: Backend setup guide
- **Apple Developer Forums**: developer.apple.com/forums
- **SwiftUI Tutorials**: developer.apple.com/tutorials/swiftui

---

**Ready to launch! 🚀**

*Built with ❤️ for SYNAPSE - MAMC Delhi*
