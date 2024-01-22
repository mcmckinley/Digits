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
    var isEnabledForQuiz: Bool
    var isEnabledForApp: Bool
    
    func formatNumber()-> String{
        let areaCode = number.prefix(3)
        let prefix = number[number.index(number.startIndex, offsetBy: 3)..<number.index(number.startIndex, offsetBy: 6)]
        let suffix = number.suffix(4)
        
        return "(\(areaCode)) \(prefix)-\(suffix)"
    }
    
    init(id: UUID = UUID(), name: String, number: String, isEnabledForQuiz: Bool = false, isEnabledForApp: Bool = true) {
        self.id = id
        self.name = name
        self.number = number
        self.isEnabledForQuiz = isEnabledForQuiz
        self.isEnabledForApp = isEnabledForApp

    }
    
    static let sampleData: [Contact] =
    [
        Contact(name: "Ones",   number: "1111111111", isEnabledForQuiz: true),
        Contact(name: "Twos",   number: "2222222222", isEnabledForQuiz: false),
        Contact(name: "Threes", number: "3333333333", isEnabledForQuiz: true),
        Contact(name: "Fours",  number: "4444444444", isEnabledForQuiz: false),
        Contact(name: "Fives",  number: "5555555555", isEnabledForQuiz: false),
        Contact(name: "Sixes",  number: "6666666666", isEnabledForQuiz: false, isEnabledForApp: false),
        Contact(name: "Sevens", number: "7777777777", isEnabledForQuiz: false),
        Contact(name: "Eights", number: "8888888888", isEnabledForQuiz: false),
        Contact(name: "Nines",  number: "9999999999", isEnabledForQuiz: false, isEnabledForApp: false),
    ]
}
