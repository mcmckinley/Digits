//
//  QuizView.swift
//  Digits
//
//  Created by Michael McKinley on 1/16/24.
//

import SwiftUI

struct QuizView: View {
    let contacts: [Contact]
    
    @State var phoneNumber: String = ""
    @FocusState private var isFocused: Bool

    @State var responses: [String] = []
    @State var index: Int = 0
    
    @State var userEntryArray: [Character] = [" "," "," "," "," "," "," "," "," "," "]
    
    var body: some View {
        // MAYBE we instead type it all to an invisible text box, and have a seperate function which displays it to each box, rather than split it up and divide the FocusState
        HStack {
            Text(String(userEntryArray[0]))
            Text(String(userEntryArray[1]))
            Text(String(userEntryArray[2]))
            Text(String(userEntryArray[3]))
            Text(String(userEntryArray[4]))
            Text(String(userEntryArray[5]))
            Text(String(userEntryArray[6]))
            Text(String(userEntryArray[7]))
            Text(String(userEntryArray[8]))
            Text(String(userEntryArray[9]))
        }
        let testContact = contacts[0]
        ZStack {
            TextField("Enter \(testContact.name)'s number:", text: $phoneNumber)
                .keyboardType(.numberPad)
                .font(.system(size: 24))
                .focused($isFocused)
                .padding([.leading], 3)
                .onChange(of: phoneNumber, initial: false) { previousNumber, currentNumber in
                    // If the user entered a digit...
                    if currentNumber > previousNumber {
                        userEntryArray[index]
                        index+=1
                        
                    }
                    // If the user removed a digit...
                    else {
                        index-=1
                    }
                    
                    // If the phone number is complete...
                    if currentNumber.count == 10 {
                        print("Phone number entered: \(currentNumber)")
                        phoneNumber = ""
                    }
                }
                .onAppear {
                    isFocused = true
            }
            PhoneNumberFrameCard()
        }
    }
}

#Preview {
    QuizView(contacts: Contact.sampleData)
}

