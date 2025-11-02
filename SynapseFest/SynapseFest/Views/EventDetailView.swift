//
//  EventDetailView.swift
//  SynapseFest
//
//  Detailed view for individual SYNAPSE fest events
//

import SwiftUI

struct EventDetailView: View {
    let event: Event
    @Environment(\.openURL) var openURL
    
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
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                ZStack(alignment: .bottomLeading) {
                    LinearGradient(
                        gradient: Gradient(colors: [categoryColor.opacity(0.8), categoryColor]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: 200)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(event.category.rawValue)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white.opacity(0.9))
                        
                        Text(event.name)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .lineLimit(2)
                    }
                    .padding()
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    // Quick Info
                    VStack(spacing: 12) {
                        InfoRow(icon: "calendar", title: "Date", value: event.date)
                        InfoRow(icon: "clock", title: "Time", value: event.time)
                        InfoRow(icon: "location.fill", title: "Venue", value: event.venue)
                        
                        if let teamSize = event.teamSize {
                            InfoRow(icon: "person.3.fill", title: "Team Size", value: teamSize)
                        }
                        
                        if let prizePool = event.prizePool {
                            InfoRow(icon: "trophy.fill", title: "Prize Pool", value: prizePool)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // Description
                    SectionView(title: "About", icon: "info.circle.fill") {
                        Text(event.detailedDescription)
                            .font(.system(size: 16))
                            .foregroundColor(.primary)
                            .lineSpacing(4)
                    }
                    
                    // Rules
                    if !event.rules.isEmpty {
                        SectionView(title: "Rules & Guidelines", icon: "list.bullet.clipboard") {
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(Array(event.rules.enumerated()), id: \.offset) { index, rule in
                                    HStack(alignment: .top, spacing: 12) {
                                        Text("\(index + 1).")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(categoryColor)
                                        
                                        Text(rule)
                                            .font(.system(size: 15))
                                            .foregroundColor(.primary)
                                    }
                                }
                            }
                        }
                    }
                    
                    // Contact Information
                    if let contactPerson = event.contactPerson, let contactEmail = event.contactEmail {
                        SectionView(title: "Contact", icon: "person.crop.circle.fill") {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "person.fill")
                                        .foregroundColor(categoryColor)
                                    Text(contactPerson)
                                        .font(.system(size: 15))
                                }
                                
                                HStack {
                                    Image(systemName: "envelope.fill")
                                        .foregroundColor(categoryColor)
                                    Text(contactEmail)
                                        .font(.system(size: 15))
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                    
                    // Registration Button
                    Button(action: {
                        if let url = URL(string: event.registrationLink) {
                            openURL(url)
                        }
                    }) {
                        HStack {
                            Image(systemName: "link.circle.fill")
                                .font(.system(size: 20))
                            
                            Text("Register Now")
                                .font(.system(size: 18, weight: .bold))
                            
                            Spacer()
                            
                            Image(systemName: "arrow.right")
                                .font(.system(size: 16, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(categoryColor)
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .top)
    }
}

struct InfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 24)
                .foregroundColor(.blue)
            
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
                .frame(width: 100, alignment: .leading)
            
            Text(value)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.primary)
            
            Spacer()
        }
    }
}

struct SectionView<Content: View>: View {
    let title: String
    let icon: String
    let content: Content
    
    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                
                Text(title)
                    .font(.system(size: 20, weight: .bold))
            }
            
            content
        }
    }
}

struct EventDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EventDetailView(event: EventDataService().events[0])
        }
    }
}
