//
//  EventDataService.swift
//  SynapseFest
//
//  Data service providing SYNAPSE fest event information
//

import Foundation

class EventDataService: ObservableObject {
    @Published var events: [Event] = []
    
    init() {
        loadEvents()
    }
    
    private func loadEvents() {
        // Sample events for SYNAPSE - MAMC Delhi Intercollege Fest
        events = [
            Event(
                name: "Battle of Bands",
                category: .cultural,
                description: "Showcase your musical talent and compete against the best college bands!",
                detailedDescription: "SYNAPSE presents the ultimate musical showdown - Battle of Bands! Bring your band and perform original compositions or covers. Compete for amazing prizes and get a chance to perform at the main fest stage. This is your opportunity to showcase your musical prowess and entertain hundreds of students!",
                date: "15th March 2024",
                time: "2:00 PM - 6:00 PM",
                venue: "MAMC Main Auditorium",
                registrationLink: "https://forms.gle/synapse-battle-of-bands",
                prizePool: "₹50,000",
                teamSize: "3-6 members",
                contactPerson: "Rahul Sharma",
                contactEmail: "cultural@synapsemamc.in",
                rules: [
                    "Band must consist of 3-6 members",
                    "Performance time limit: 15 minutes",
                    "Original compositions are encouraged",
                    "Basic instruments will be provided",
                    "Teams must arrive 30 minutes before their slot"
                ]
            ),
            Event(
                name: "Hackathon 2024",
                category: .technical,
                description: "24-hour coding marathon to solve real-world healthcare challenges",
                detailedDescription: "Join SYNAPSE's flagship hackathon focusing on healthcare innovation! Teams will work for 24 hours to develop innovative solutions using technology. Whether it's AI in diagnostics, patient management systems, or health awareness apps - bring your ideas to life. Mentors from top tech companies and healthcare professionals will guide you throughout.",
                date: "16th-17th March 2024",
                time: "10:00 AM (Day 1) - 10:00 AM (Day 2)",
                venue: "MAMC Computer Lab & Innovation Center",
                registrationLink: "https://forms.gle/synapse-hackathon-2024",
                prizePool: "₹1,00,000",
                teamSize: "2-4 members",
                contactPerson: "Priya Patel",
                contactEmail: "tech@synapsemamc.in",
                rules: [
                    "Teams of 2-4 members allowed",
                    "Must bring your own laptops",
                    "Internet will be provided",
                    "Food and refreshments provided",
                    "Final submission deadline: 9:00 AM Day 2",
                    "All code must be original",
                    "Open source libraries are allowed"
                ]
            ),
            Event(
                name: "Medical Quiz Competition",
                category: .medical,
                description: "Test your medical knowledge in this challenging quiz competition",
                detailedDescription: "SYNAPSE's Medical Quiz is the ultimate test of medical knowledge! Compete in multiple rounds covering anatomy, physiology, pathology, pharmacology, and current medical affairs. Perfect for medical students to test their knowledge and win exciting prizes. Preliminary rounds will be conducted online, followed by finals at the fest.",
                date: "14th March 2024",
                time: "11:00 AM - 2:00 PM",
                venue: "MAMC Lecture Hall 3",
                registrationLink: "https://forms.gle/synapse-medical-quiz",
                prizePool: "₹30,000",
                teamSize: "2 members",
                contactPerson: "Dr. Anjali Mehta",
                contactEmail: "quiz@synapsemamc.in",
                rules: [
                    "Teams of 2 members only",
                    "Participants must be current medical students",
                    "Three rounds: Prelims, Semi-finals, and Finals",
                    "Negative marking in buzzer rounds",
                    "Use of mobile phones strictly prohibited",
                    "Decisions of quizmaster are final"
                ]
            ),
            Event(
                name: "Street Dance Championship",
                category: .cultural,
                description: "Hip-hop, breaking, popping - show us your best moves!",
                detailedDescription: "Get ready to groove at SYNAPSE's Street Dance Championship! Whether you're into hip-hop, breaking, popping, locking, or contemporary - this is your stage. Solo and group categories available. Professional judges from the dance industry will evaluate performances. Cash prizes and trophies for winners!",
                date: "15th March 2024",
                time: "10:00 AM - 1:00 PM",
                venue: "MAMC Outdoor Stage",
                registrationLink: "https://forms.gle/synapse-street-dance",
                prizePool: "₹40,000",
                teamSize: "Solo or Group (max 8)",
                contactPerson: "Arjun Singh",
                contactEmail: "dance@synapsemamc.in",
                rules: [
                    "Solo and group categories (max 8 members)",
                    "Performance time: 3-5 minutes",
                    "Music must be submitted 2 days prior",
                    "Props allowed but must be safe",
                    "Participants must wear appropriate attire",
                    "Vulgarity will lead to disqualification"
                ]
            ),
            Event(
                name: "Debate Competition",
                category: .literary,
                description: "Engage in intellectual discourse on contemporary healthcare topics",
                detailedDescription: "SYNAPSE's Debate Competition brings together the brightest minds to discuss pressing healthcare and societal issues. Topics range from medical ethics to healthcare policy. Sharpen your argumentative skills and engage in meaningful discourse. Individual participation with topics announced on the spot.",
                date: "14th March 2024",
                time: "3:00 PM - 6:00 PM",
                venue: "MAMC Seminar Hall",
                registrationLink: "https://forms.gle/synapse-debate",
                prizePool: "₹20,000",
                teamSize: "Individual",
                contactPerson: "Sneha Gupta",
                contactEmail: "literary@synapsemamc.in",
                rules: [
                    "Individual participation only",
                    "Topics announced 15 minutes before round",
                    "Speaking time: 5 minutes per speaker",
                    "Rebuttal time: 2 minutes",
                    "Multiple elimination rounds",
                    "Judges' decision is final"
                ]
            ),
            Event(
                name: "Photography Exhibition",
                category: .arts,
                description: "Capture the essence of life through your lens",
                detailedDescription: "SYNAPSE invites photography enthusiasts to showcase their best work! Theme: 'Healthcare & Humanity'. Submit your entries showcasing the connection between medicine, healthcare workers, patients, and the human spirit. Winning entries will be exhibited at the fest and on our social media platforms.",
                date: "14th-17th March 2024",
                time: "All Day Exhibition",
                venue: "MAMC Art Gallery",
                registrationLink: "https://forms.gle/synapse-photography",
                prizePool: "₹15,000",
                teamSize: "Individual",
                contactPerson: "Vikram Joshi",
                contactEmail: "arts@synapsemamc.in",
                rules: [
                    "Maximum 3 entries per participant",
                    "Minimum resolution: 3000x2000 pixels",
                    "Submit in JPEG format",
                    "Original photographs only",
                    "Minor editing allowed (no major manipulation)",
                    "Submit with title and brief description",
                    "Deadline: 10th March 2024"
                ]
            ),
            Event(
                name: "Football Tournament",
                category: .sports,
                description: "Inter-college football tournament - may the best team win!",
                detailedDescription: "SYNAPSE's Football Tournament brings together teams from medical colleges across Delhi. Show your athletic prowess and team spirit! Knockout format with matches scheduled throughout the fest. Professional referees, quality ground, and exciting prizes await. Limited slots available!",
                date: "14th-16th March 2024",
                time: "7:00 AM - 11:00 AM (Daily)",
                venue: "MAMC Sports Ground",
                registrationLink: "https://forms.gle/synapse-football",
                prizePool: "₹35,000",
                teamSize: "11 players + 5 substitutes",
                contactPerson: "Karan Malhotra",
                contactEmail: "sports@synapsemamc.in",
                rules: [
                    "Team of 11 players + 5 substitutes",
                    "All participants must be current college students",
                    "ID cards mandatory",
                    "Match duration: 40 minutes (20+20)",
                    "Knockout format",
                    "Yellow and red card rules apply",
                    "Team must bring their own kit"
                ]
            ),
            Event(
                name: "Poetry Slam",
                category: .literary,
                description: "Express yourself through the power of words and verse",
                detailedDescription: "Step into the spotlight at SYNAPSE's Poetry Slam! Perform your original poetry on any theme. Whether it's spoken word, traditional verse, or experimental poetry - we celebrate all forms. Three rounds of competition with audience voting and expert judging. This is your stage to make words come alive!",
                date: "15th March 2024",
                time: "4:00 PM - 7:00 PM",
                venue: "MAMC Open Air Theatre",
                registrationLink: "https://forms.gle/synapse-poetry-slam",
                prizePool: "₹18,000",
                teamSize: "Individual",
                contactPerson: "Meera Reddy",
                contactEmail: "poetry@synapsemamc.in",
                rules: [
                    "Individual participation only",
                    "All poetry must be original",
                    "Performance time: 3 minutes maximum",
                    "No props or music allowed",
                    "Hindi, English, or Hinglish permitted",
                    "Audience voting + judge scoring",
                    "Top 10 advance to final round"
                ]
            )
        ]
    }
    
    // Future: Add Azure backend integration
    func fetchEventsFromAzure() {
        // TODO: Implement Azure backend API integration
        // This function can be used to fetch real-time event data from Azure
        // using Azure Functions, Azure App Service, or Azure Cosmos DB
    }
    
    func submitRegistration(eventId: UUID, participantData: [String: Any]) {
        // TODO: Implement Azure backend registration submission
        // Send registration data to Azure backend for processing
    }
}
