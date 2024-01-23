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

    var body: some View {
        
        
        let testContact = contacts[0]
        
        VStack {
            Text(phoneNumber)
                .font(.system(size: 24))

            TextField("Enter \(testContact.name)'s number:", text: $phoneNumber)
                .keyboardType(.numberPad)
                .font(.system(size: 24))
                .focused($isFocused)
                .padding([.leading], 3)
                .onChange(of: phoneNumber, initial: false) { newPhoneNumber, what in
                    if newPhoneNumber.count == 9 {
                    // Perform your desired action when 10 characters are entered
                    print("Phone number entered: \(newPhoneNumber)")
                    // Disable the keypad or perform any other action here
                    isFocused = false
                }
            }
        }
        .onAppear {
            isFocused = true
        }
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

