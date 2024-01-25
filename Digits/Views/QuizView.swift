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
    
    // The currently entered number by the user
    @State var phoneNumber: String = ""
    
    // Split up version of the user's current answer
    @State private var userEntryArray: [String] = [] // = ["1", "1","1","1","1","1","1","1","1","1"]
    
    // Whether the user is focused on the textbox - necessary, I think
    @FocusState private var isFocused: Bool
    
    // List of the user's responses
    @State private var responses: [Response] = Response.sampleData
    
    @State private var currentContact: Contact = Contact.sampleData[0]
    
    @State var listYPosition: Double = 30.0
    

    var body: some View {
        // Using a ZStack to display each element on top of each other
        // a) - The characters as they are typed
        // b) - The TextField that accepts the user's input
        // c) - The phone number frame: (___)___-____
        
        List(responses) {response in
            AnswerCard(response: response)
        }
        //.listRowSeparator(.hidden)
        //.listSectionSeparator(.hidden)
        .environment(\.defaultMinListRowHeight, 70)
        .listStyle(.plain)
        .position(CGPoint(x: 200.0, y: 200.0))
        
        ZStack {
            // Dynamic display of the user-entered phone number
            HStack (spacing: 0){
                Spacer().frame(width: 32)
                // Not sure how this next line works, needed openAI to help me here
                ForEach(Array(userEntryArray.enumerated()), id: \.0) { index, char in
                    Text(char)
                        .font(.system(size: 32))
                        .padding([.trailing], 7)
                        .fontDesign(.monospaced)
                    // Currently, these conditions will not execute
                    if index == 2 {
                        Spacer().frame(width: 23)
                    }
                    if index == 5 {
                        Spacer().frame(width: 18)
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
                        responses.append(Response(answer: currentContact.number, userResponse: phoneNumber))
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
        .position(CGPoint(x: 200.0, y: 30.0))
    }
}

#Preview {
    QuizView(contacts: Contact.sampleData)
}

