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
    
    var body: some View {
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
        
        
        // Potentially will want this code in the TextField, to prevent any non-numerical answers
        /*
                    .onReceive(Just(enteredNum)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.enteredNum = filtered
                        }
                    }
         */
        
        
    }
}

#Preview {
    QuizView(contacts: Contact.sampleData)
}

