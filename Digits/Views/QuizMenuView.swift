//
//  QuizView.swift
//  Digits
//
//  Created by Michael McKinley on 1/16/24.
//

import SwiftUI

struct QuizMenuView: View {
    let contacts: [Contact]
    
    var body: some View {
        VStack {
            Text("Quiz time..")
        }
    }
}

#Preview {
    QuizMenuView(contacts: Contact.sampleData)
}

