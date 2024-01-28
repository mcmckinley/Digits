//
//  Response.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      - Stores a response from the user

import Foundation

struct Response: Identifiable {
    let id: UUID
    let answer: String
    let userResponse: String
    let contactName: String
    
    var answerArray: [String] {
        answer.map{String($0)}
    }
    var userResponseArray: [String] {
        userResponse.map{String($0)}
    }
    
    var isCorrect: Bool {
        userResponse == answer
    }
    
    var rightAnswerAt: [Bool] {
        zip(answerArray, userResponseArray).map { $0 == $1 }
    }
    
    init(id: UUID = UUID(), answer: String, userResponse: String, contactName: String) {
        self.id = id
        self.answer = answer
        self.userResponse = userResponse
        self.contactName = contactName
    }
    
    static let sampleData: [Response] =
    [
        Response(answer: "1111111111", userResponse: "1111111111", contactName: "Ones"),
        Response(answer: "2222222222", userResponse: "2222222222", contactName: "Twos"),
        Response(answer: "3333333333", userResponse: "3343333333", contactName: "Threes"),
        Response(answer: "3333333333", userResponse: "3334333333", contactName: "Threes"),
        Response(answer: "3333333333", userResponse: "3333333333", contactName: "Threes"),
        Response(answer: "4444444444", userResponse: "4444444444", contactName: "Fours")
    ]
    
    
    func formatNumber(number: String) -> String {
        let areaCode = number.prefix(3)
        let prefix = number[number.index(number.startIndex, offsetBy: 3)..<number.index(number.startIndex, offsetBy: 6)]
        let suffix = number.suffix(4)
        
        return "(\(areaCode)) \(prefix)-\(suffix)"
    }
}
