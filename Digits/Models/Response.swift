//
//  Response.swift
//  Digits
//
//  Created by Michael McKinley on 1/24/24.
//

import Foundation

struct Response: Identifiable {
    let id: UUID
    let answer: String
    let userResponse: String
    
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
    
    init(id: UUID = UUID(), answer: String, userResponse: String) {
        self.id = id
        self.answer = answer
        self.userResponse = userResponse
    }
    
    static let sampleData: [Response] =
    [
        Response(answer: "1111111111", userResponse: "1234567890"),
        Response(answer: "1111111111", userResponse: "1122112211")
    ]
}
