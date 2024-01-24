//
//  CorrectAnswerCard.swift
//  Digits
//
//  Created by Michael McKinley on 1/23/24.
//

import SwiftUI
import Foundation

struct AnswerCard: View {
    let correctAnswer: String
    let userEntry: String
    
    var body: some View {
        Text(userEntry)
    }
}

struct AnswerCard_Previews: PreviewProvider {
    static var previews: some View {
        AnswerCard(correctAnswer: "(123)456-7890", userEntry: "(123)456-7890")
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
