//
//  Contacts.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      - Stores a contact's information

import Foundation

struct Contact: Identifiable, Codable, Comparable {
    var id: UUID
    var name: String
    var numbers: [PhoneNumber]
    
    /// Enabled:
    ///     true: Will show up in quiz
    ///     false: Will not show up in quiz
    var enabled: Bool
    
    /// Allowed:
    ///     true: Will show up in settings screen, to be enabled or disabled for quizzing
    ///     false: Will not show up in settings screen
    var allowed: Bool
    
    init(id: UUID = UUID(), name: String, numbers: [PhoneNumber], enabled: Bool = false, allowed: Bool = false) {
        self.id = id
        self.name = name
        self.numbers = numbers
        self.enabled = enabled
        self.allowed = allowed
    }
    
    // Allows for alphabetical comparison of contacts.
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.name < rhs.name
    }
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        print("ERROR! this should never be used.")
        return false
    }
    
    static let sampleData: [Contact] =
    [
        Contact(name: "Ones",   
                numbers: [
                    PhoneNumber(
                        type: "home",
                        number: "1111111111"
                    )
                ],
                enabled: true,
                allowed: true),
        Contact(name: "Twos",
                numbers: [
                    PhoneNumber(
                        type: "home",
                        number: "1111111111"
                    )
                ],
                enabled: true,
                allowed: true),
        Contact(name: "Threes",
                numbers: [
                    PhoneNumber(
                        type: "home",
                        number: "1111111111"
                    )
                ],
                enabled: false,
                allowed: true),
        Contact(name: "Fours",
                numbers: [
                    PhoneNumber(
                        type: "home",
                        number: "1111111111"
                    )
                ],
                enabled: false,
                allowed: true),
        Contact(name: "Fives",
                numbers: [
                    PhoneNumber(
                        type: "home",
                        number: "1111111111"
                    )
                ],
                enabled: false,
                allowed: false),
        Contact(name: "Sixes",
                numbers: [
                    PhoneNumber(
                        type: "home",
                        number: "1111111111"
                    )
                ],
                enabled: false,
                allowed: false),
      
    ]
     
    // static let sampleData: [Contact] = []
    
    
    static var emptyContact: Contact {
        Contact(name: "", numbers: [PhoneNumber(type: "hi", number: "")])
    }
    
}


