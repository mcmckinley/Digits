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
    var enabledForQuiz: Bool
    
    func formatNumber()-> String{
        let areaCode = number.prefix(3)
        let prefix = number[number.index(number.startIndex, offsetBy: 3)..<number.index(number.startIndex, offsetBy: 6)]
        let suffix = number.suffix(4)
        
        return "(\(areaCode)) \(prefix)-\(suffix)"
    }
    
    init(id: UUID = UUID(), name: String, number: String, enabledForQuiz: Bool = false) {
        self.id = id
        self.name = name
        self.number = number
        self.enabledForQuiz = enabledForQuiz
    }
    
    static let sampleData: [Contact] =
    [
        Contact(name: "Ones",   number: "1111111111", enabledForQuiz: true),
        Contact(name: "Twos",   number: "2222222222", enabledForQuiz: false),
        Contact(name: "Threes", number: "3333333333", enabledForQuiz: true),
        Contact(name: "Fours",  number: "4444444444", enabledForQuiz: false),
        Contact(name: "Fives",  number: "5555555555", enabledForQuiz: false),
        Contact(name: "Sixes",  number: "6666666666", enabledForQuiz: false),
        Contact(name: "Sevens",  number: "7777777777", enabledForQuiz: false),
        Contact(name: "Eights",  number: "8888888888", enabledForQuiz: false),
        Contact(name: "Nines",  number: "9999999999", enabledForQuiz: false),



    ]
}
