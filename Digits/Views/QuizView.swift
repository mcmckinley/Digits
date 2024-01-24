//
//  QuizView.swift
//  Digits
//
//  Created by Michael McKinley on 1/16/24.
//

import SwiftUI
import Foundation

struct QuizView: View {
    let contacts: [Contact]
    
    @State var phoneNumber: String = ""
    @FocusState private var isFocused: Bool

    @State var responses: [String] = []
    @State var index: Int = 0
    
    @State private var userEntryArray: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    
    var body: some View {
        // MAYBE we instead type it all to an invisible text box, and have a seperate function which displays it to each box, rather than split it up and divide the FocusState
        
        
        
        let testContact = contacts[0]
        ZStack {
            HStack {
                ForEach(userEntryArray, id: \.self) { char in
                    Text(char)
                        .font(.system(size: 24))
                }
                Spacer()
                
            }
            TextField("", text: $phoneNumber)
                .keyboardType(.numberPad)
                .opacity(0)
                .font(.system(size: 24))
                .focused($isFocused)
                .padding([.leading], 3)
                .onChange(of: phoneNumber, initial: false) { previousNumber, currentNumber in
                    
                    userEntryArray = phoneNumber.map{String($0)}
                    for entry in userEntryArray {
                        print("Entry:  \(entry)")
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

