//
//  Contacts.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      - Stores a contact's information

import Foundation

struct Contact: Identifiable {
    var id: UUID
    var name: String
    var number: String
    var numberFull: String {
        formatNumber()
    }
    var editingNumber: String
    
    /// Enabled:
    ///     true: Will show up in quiz
    ///     false: Will not show up in quiz
    var enabled: Bool
    
    /// Allowed:
    ///     true: Will show up in settings screen, to be enabled or disabled for quizzing
    ///     false: Will not show up in settings screen
    var allowed: Bool
    
    func formatNumber()-> String{
        if number.count != 10 {
            return "Please enter 10 digits."
        }
        
        let areaCode = number.prefix(3)
        let prefix = number[number.index(number.startIndex, offsetBy: 3)..<number.index(number.startIndex, offsetBy: 6)]
        let suffix = number.suffix(4)
        
        return "(\(areaCode)) \(prefix)-\(suffix)"
    }
    
    init(id: UUID = UUID(), name: String, number: String, enabled: Bool = false, allowed: Bool = false) {
        self.id = id
        self.name = name
        self.number = number
        self.editingNumber = number
        self.enabled = enabled
        self.allowed = allowed
    }
    
    static let sampleData: [Contact] =
    [
        Contact(name: "Ones",   number: "1111111111", enabled: true,  allowed: true),
        Contact(name: "Twos",   number: "2222222222", enabled: true,  allowed: true),
        Contact(name: "Threes", number: "3333333333", enabled: true,  allowed: true),
    
        Contact(name: "Fours",  number: "4444444444"),
        Contact(name: "Fives",  number: "5555555555"),
        Contact(name: "Sixes",  number: "6666666666"),
    
        Contact(name: "Sevens", number: "7777777777"),
        Contact(name: "Eights", number: "8888888888"),
        Contact(name: "Nines",  number: "9999999999"),
    ]
    static var emptyContact: Contact {
        Contact(name: "", number: "")
    }
    
}


