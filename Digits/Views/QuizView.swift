//
//  QuizView.swift
//  Digits
//
//  Created by Michael McKinley on 1/16/24.
//

import SwiftUI

struct QuizView: View {
    let contacts: [Contact]
    
    var body: some View {
        VStack {
            Text("Quiz time..")
            Spacer()
            
            
            Button(action: {
                // Action to perform when the button is tapped
                print("Button tapped!")
            }) {
                Text("Begin")
                    .bold()
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 15)
                    .padding([.leading, .trailing], 150)
                    .background(Color.blue)
                    .cornerRadius(10)
                
            }
            .padding()
        }
    }
}

#Preview {
    QuizView(contacts: Contact.sampleData)
}
