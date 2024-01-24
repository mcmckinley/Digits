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
    
    @State private var userEntryArray: [String] = []
    
    var body: some View {
        // Using a ZStack to display each element on top of each other
        // a) - The characters as they are typed
        // b) - The TextField that accepts the user's input
        // c) - The phone number frame: (___)___-____
        
        ZStack {
            // Dynamic display of the user-entered phone number
            HStack (spacing: 0){
                Spacer().frame(width: 20)
                // Not sure how this next line works, needed openAI to help me here
                ForEach(Array(userEntryArray.enumerated()), id: \.0) { index, char in
                    Text(char)
                        .font(.system(size: 30))
                        .padding([.trailing], 8)
                        .fontDesign(.monospaced)
                    // Currently, these conditions will not execute
                    if index == 2 {
                        Spacer().frame(width: 12)
                    }
                    if index == 5 {
                        Spacer().frame(width: 12)
                    }
                }
                Spacer()
            }
            
            
            // Where the program receives input
            TextField("", text: $phoneNumber)
                .keyboardType(.numberPad)
                .opacity(0)
                .font(.system(size: 24))
                .focused($isFocused)
                .padding([.leading], 3)
                .onChange(of: phoneNumber, initial: false) { previousNumber, currentNumber in
                    
                    userEntryArray = phoneNumber.map{String($0)}
                    
                    // If the phone number is complete...
                    if currentNumber.count == 10 {
                        print("Phone number entered: \(currentNumber)")
                        phoneNumber = ""
                        
                        // Will I need this?
                        //userEntryArray = []
                    }
                }
                .onAppear {
                    isFocused = true
            }
            
            // The underlying frame
            PhoneNumberFrameCard()
        }
    }
}

#Preview {
    QuizView(contacts: Contact.sampleData)
}

