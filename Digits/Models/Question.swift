//
//  Question.swift
//  Digits Quiz
//
//  Created by Michael McKinley
//
//  - Stores a question for the user's quiz

import Foundation

struct Question: Identifiable {
    var id: UUID
    var type: String
    var contactName: String
    var answer: String
    
    init(id: UUID = UUID(), type: String, contactName: String, answer: String) {
        self.id = id
        self.type = type
        self.contactName = contactName
        self.answer = answer
    }
}

func createQuestions (contacts: [Contact]) -> [Question]{
    var questions: [Question] = []
    
    for contact in contacts {
        for number in contact.numbers {
            questions.append(
                Question(
                    type: number.type,
                    contactName: contact.name,
                    answer: number.number // I have to change this
                )
            )
        }
    }
    
    return questions
}
