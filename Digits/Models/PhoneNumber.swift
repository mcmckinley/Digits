//
//  PhoneNumber.swift
//  Digits Quiz
//
//  Created by Michael McKinley
//
//  Stores information on a phone number

import Foundation


struct PhoneNumber: Identifiable, Codable {
    var id: UUID
    var type: String
    var number: String
    var numberFull: String {
        formatNumber()
    }
    var editingNumber: String
    
    /// Enabled:
    ///     true: Will show up in quiz
    ///     false: Will not show up in quiz
    var enabled: Bool
    
    init(id: UUID = UUID(), type: String, number: String, enabled: Bool = false) {
        self.id = id
        self.type = type
        self.number = number
        self.editingNumber = number
        self.enabled = enabled
    }
    
    func formatNumber()-> String{
        if number.count != 10 {
            return "Please enter 10 digits."
        }
        
        
        let areaCode = number.prefix(3)
        let prefix = number[number.index(number.startIndex, offsetBy: 3)..<number.index(number.startIndex, offsetBy: 6)]
        let suffix = number.suffix(4)
        
        return "(\(areaCode)) \(prefix)-\(suffix)"
    }
}


