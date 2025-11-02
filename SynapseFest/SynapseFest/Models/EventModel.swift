//
//  EventModel.swift
//  SynapseFest
//
//  Event data model for SYNAPSE fest events
//

import Foundation

struct Event: Identifiable, Codable {
    let id: UUID
    let name: String
    let category: EventCategory
    let description: String
    let detailedDescription: String
    let date: String
    let time: String
    let venue: String
    let registrationLink: String
    let prizePool: String?
    let teamSize: String?
    let contactPerson: String?
    let contactEmail: String?
    let rules: [String]
    
    enum EventCategory: String, Codable {
        case cultural = "Cultural"
        case technical = "Technical"
        case sports = "Sports"
        case literary = "Literary"
        case arts = "Arts & Crafts"
        case medical = "Medical Quiz"
    }
    
    init(id: UUID = UUID(), name: String, category: EventCategory, description: String, 
         detailedDescription: String, date: String, time: String, venue: String, 
         registrationLink: String, prizePool: String? = nil, teamSize: String? = nil, 
         contactPerson: String? = nil, contactEmail: String? = nil, rules: [String] = []) {
        self.id = id
        self.name = name
        self.category = category
        self.description = description
        self.detailedDescription = detailedDescription
        self.date = date
        self.time = time
        self.venue = venue
        self.registrationLink = registrationLink
        self.prizePool = prizePool
        self.teamSize = teamSize
        self.contactPerson = contactPerson
        self.contactEmail = contactEmail
        self.rules = rules
    }
}
