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
    @State private var userEntryArray: [String] = [] //["1", "1","1","1","1","1","1","1","1","1"]
    
    // Whether the user is focused on the textbox - necessary, I think
    @FocusState private var isFocused: Bool
    
    // List of the user's responses
    @State private var responses: [Response] = [] //Response.sampleData
    
    // Current contact in question
    @State private var currentContact: Contact = Contact.sampleData[0]
    
    @Environment(\.colorScheme) var colorScheme

    // Red and green flashing after responses
    @State var redFeedback: Double = 0
    @State var greenFeedback: Double = 0
    @State var blueFeedback: Double = 0
    
    // Handle the text color flashin based on
    private func feedback(correct: Bool){
        let lightMode: Bool = (colorScheme == .light)
        
        if correct && lightMode {
            greenFeedback = 1
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                greenFeedback -= 0.1
                if greenFeedback <= 0 {
                    timer.invalidate()
                }
            }
        } else if !correct && lightMode {
            redFeedback = 1
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                redFeedback -= 0.05
                if redFeedback <= 0 {
                    timer.invalidate()
                }
            }
        } else if correct { // } && lightMode {
            redFeedback = 0
            blueFeedback = 0
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                redFeedback += 0.1
                blueFeedback += 0.1
                if redFeedback >= 1 {
                    timer.invalidate()
                }
            }
        } else { // if !correct && colorScheme == .dark
            greenFeedback = 0
            blueFeedback = 0
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                greenFeedback += 0.1
                blueFeedback += 0.1
                if greenFeedback >= 1 {
                    timer.invalidate()
                }
            }
        }
    }
    private func updateColors(){
        redFeedback   = colorScheme == .light ? 0 : 1
        blueFeedback  = colorScheme == .light ? 0 : 1
        greenFeedback = colorScheme == .light ? 0 : 1
    }

    var body: some View {
        VStack {
            // Enter <person>'s digits
            HStack {
                Spacer().frame(width: 10)
                Text("Enter")
                    .font(.title)
                    .bold()
                Text("\(currentContact.name)'s")
                    .font(.title)
                    .bold()
                Text("digits:")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .foregroundColor(Color(red: redFeedback, green: greenFeedback, blue: blueFeedback))
            .onChange(of: colorScheme, initial: true) { newColorScheme, a in
                updateColors()
            }

            
            // The number you just entered
            HStack {
                if let lastResponse = responses.last {
                    AnswerCard(response: lastResponse)
                } else {
                    BlankCard()
                }
            }
            
            // Where you type the number
            HStack {
                ZStack {
                    // Dynamic display of the user-entered phone number
                    HStack (spacing: 0){
                        Spacer().frame(width: 32)
                        ForEach(Array(userEntryArray.enumerated()), id: \.0) { index, char in
                            Text(char)
                                .font(.system(size: 30))
                                .padding([.trailing], 7)
                                .fontDesign(.monospaced)
                            if index == 2 {
                                Spacer().frame(width: 23)
                            }
                            if index == 5 {
                                Spacer().frame(width: 18)
                            }
                        }
                        Spacer()
                    }
                    
                    // The underlying frame
                    PhoneNumberFrameCard()
                    
                    // Where the program receives input - this is invisible
                    TextField("", text: $phoneNumber)
                        .keyboardType(.numberPad)
                        .opacity(0)
                        .font(.system(size: 24))
                        .focused($isFocused)
                        .padding([.leading], 3)
                        .onAppear {
                            isFocused = true
                        }
                        .onChange(of: phoneNumber, initial: false) { previousNumber, currentNumber in
                            userEntryArray = phoneNumber.map{String($0)}
                            
                            if currentNumber.count == 10 {
                                responses.append(Response(answer: currentContact.number, userResponse: phoneNumber))
                                
                                // If a correct asnwer is given, assign a new random contact
                                if let lastResponse = responses.last, let randomContact = Contact.sampleData.randomElement() {
                                    feedback(correct: lastResponse.isCorrect)
                                    phoneNumber = ""

                                    if lastResponse.isCorrect {
                                        currentContact = randomContact
                                    }
                                }
                            }
                        }
                }
            }
        }
    }
    
}

#Preview {
    QuizView(contacts: Contact.sampleData)
}

