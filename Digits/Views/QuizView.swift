//
//  QuizView.swift
//  Digits
//
//  Created by Michael McKinley on 1/16/24.
//

import SwiftUI
import Combine

struct QuizView: View {
    let contacts: [Contact]
    
    @State var phoneNumber: String = ""
    @FocusState private var isFocused: Bool

    @State var responses: [String] = []
    @State var index: Int = 0
    
    var body: some View {
        // MAYBE we instead type it all to an invisible text box, and have a seperate function which displays it to each box, rather than split it up and divide the FocusState
        
        
        let testContact = contacts[0]
        TextField("Enter \(testContact.name)'s number:", text: $phoneNumber)
            .keyboardType(.numberPad)
            .font(.system(size: 24))
            .focused($isFocused)
            .padding([.leading], 3)
            .onChange(of: phoneNumber, initial: false) { previousNumber, currentNumber in
                if currentNumber.count == 10 {
                    print("Phone number entered: \(currentNumber)")
                    phoneNumber = ""
                }
            }
            .onAppear {
                isFocused = true
            }
    }
}

#Preview {
    QuizView(contacts: Contact.sampleData)
}

