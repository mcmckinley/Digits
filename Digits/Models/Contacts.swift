//
//  Contacts.swift
//  Digits
//
//  Created by Michael McKinley on 1/16/24.
//

import Foundation

struct Contact: Identifiable {
    var id: UUID
    var name: String
    var number: String
    var numberFull: String {
        formatNumber()
    }
    
    func formatNumber()-> String{
        let areaCode = number.prefix(3)
        let prefix = number[number.index(number.startIndex, offsetBy: 3)..<number.index(number.startIndex, offsetBy: 6)]
        let suffix = number.suffix(4)
        
        return "(\(areaCode)) \(prefix)-\(suffix)"
    }
    
    init(id: UUID = UUID(), name: String, number: String) {
        self.id = id
        self.name = name
        self.number = number
    }
    
    static let sampleData: [Contact] =
    [
        Contact(name: "***REMOVED***", number: "***REMOVED***"),
        Contact(name: "Michael", number: "***REMOVED***"),
        Contact(name: "***REMOVED***", number: "***REMOVED***"),
    ]
}
