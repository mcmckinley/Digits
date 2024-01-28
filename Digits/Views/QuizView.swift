//
//  QuizView.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      - Manages QuizActiveView and QuizSummaryView. Directs user to either of these views.

import SwiftUI

struct QuizView: View {
    let contacts: [Contact]
    
    @State var responses: [Response] = []

    @State var quizIsFinished: Bool = false;
    
    var body: some View {
        if quizIsFinished {
            QuizSummaryView(responses: $responses, quizIsFinished: $quizIsFinished)
        } else {
            QuizActiveView(contacts: contacts, responses: $responses, quizIsFinished: $quizIsFinished)
        }
    }
}

#Preview {
    QuizView(contacts: Contact.sampleData)
}
