//
//  EventListView.swift
//  SynapseFest
//
//  List view displaying all SYNAPSE fest events
//

import SwiftUI

struct EventListView: View {
    let events: [Event]
    @State private var selectedCategory: Event.EventCategory? = nil
    
    var filteredEvents: [Event] {
        if let category = selectedCategory {
            return events.filter { $0.category == category }
        }
        return events
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Category Filter
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    CategoryButton(title: "All", isSelected: selectedCategory == nil) {
                        selectedCategory = nil
                    }
                    
                    ForEach([Event.EventCategory.cultural, .technical, .sports, .literary, .arts, .medical], id: \.self) { category in
                        CategoryButton(title: category.rawValue, isSelected: selectedCategory == category) {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
            }
            .background(Color(.systemGray6))
            
            // Events List
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(filteredEvents) { event in
                        NavigationLink(destination: EventDetailView(event: event)) {
                            EventCardView(event: event)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
        }
    }
}

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color(.systemGray5))
                .cornerRadius(20)
        }
    }
}

struct EventCardView: View {
    let event: Event
    
    var categoryColor: Color {
        switch event.category {
        case .cultural: return .orange
        case .technical: return .blue
        case .sports: return .green
        case .literary: return .purple
        case .arts: return .pink
        case .medical: return .red
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(event.category.rawValue)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(categoryColor)
                    .cornerRadius(12)
                
                Spacer()
                
                Image(systemName: categoryIcon(for: event.category))
                    .font(.system(size: 24))
                    .foregroundColor(categoryColor)
            }
            
            Text(event.name)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
                .lineLimit(2)
            
            Text(event.description)
                .font(.system(size: 14))
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            HStack {
                Label(event.date, systemImage: "calendar")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Label(event.time, systemImage: "clock")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Label(event.venue, systemImage: "location.fill")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.blue)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
    
    func categoryIcon(for category: Event.EventCategory) -> String {
        switch category {
        case .cultural: return "music.note"
        case .technical: return "cpu"
        case .sports: return "sportscourt"
        case .literary: return "book.fill"
        case .arts: return "paintbrush.fill"
        case .medical: return "cross.case.fill"
        }
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView(events: EventDataService().events)
    }
}
