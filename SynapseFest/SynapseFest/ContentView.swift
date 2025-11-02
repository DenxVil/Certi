//
//  ContentView.swift
//  SynapseFest
//
//  SYNAPSE - MAMC Delhi Intercollege Fest
//

import SwiftUI

struct ContentView: View {
    @StateObject private var eventService = EventDataService()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header Section
                ZStack {
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    
                    VStack(spacing: 10) {
                        Image(systemName: "star.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                        
                        Text("SYNAPSE")
                            .font(.system(size: 42, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text("MAMC Delhi Intercollege Fest")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white.opacity(0.9))
                        
                        Text("Connecting Minds, Creating Memories")
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(.white.opacity(0.8))
                            .italic()
                    }
                    .padding(.vertical, 30)
                }
                .frame(height: 250)
                
                // Events List
                EventListView(events: eventService.events)
            }
            .navigationBarHidden(true)
            .ignoresSafeArea(edges: .top)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
