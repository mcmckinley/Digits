//
//  QuizActiveView.swift
//  Digits
//
//  Created by Michael McKinley on 1/16/24.
//

import SwiftUI
import Foundation

struct QuizActiveView: View {
    @State var contacts: [Contact]
    
    @State private var contactIndex: Int = 0
    
    @Binding var responses: [Response]
    
    @Binding var quizIsFinished: Bool

    // The currently entered number by the user
    @State var userEntry: String = ""
    // Same as userEntry, but split into characters
    @State private var userEntryArray: [String] = []
    
    // Whether the user is focused on the textbox - necessary, I think
    @FocusState private var isFocused: Bool
    
    @Environment(\.colorScheme) var colorScheme

    // Red and green flashing after responses
    @State var redFeedback: Double = 0
    @State var greenFeedback: Double = 0
    @State var blueFeedback: Double = 0
    
    // Handle the text color flashing based on if asnwer is correct
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
    
    // Handle a response, either when submitted or skipped
    private func handleResponse(skipped: Bool = false){
        if skipped {
            userEntry = "??????????"
        }

        responses.append(
            Response(answer: contacts[contactIndex].number,
                     userResponse: userEntry,
                     contactName: contacts[contactIndex].name)
            )
        
        userEntry = ""
        userEntryArray = []
        
        if let lastResponse = responses.last {
            if lastResponse.isCorrect {
                feedback(correct: true)
                //timeRemaining = timePerQuestion

                if contactIndex == contacts.count-1 {
                    quizIsFinished = true
                } else {
                    contactIndex+=1
                }
            } else {
                feedback(correct: false)
            }
        }
    }
    
    

    var body: some View {
        VStack {
            Spacer().frame(height: 120)

            // Enter <person>'s digits
                HStack {
                Spacer().frame(width: 10)
                Text("Enter \(contacts[contactIndex].name)'s digits:")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .foregroundColor(Color(red: redFeedback, green: greenFeedback, blue: blueFeedback))
            .onChange(of: colorScheme, initial: true) { _, _ in
                updateColors()
            }

            
            // The number you just entered
            HStack {
                if let lastResponse = responses.last {
                    if !lastResponse.isCorrect {
                        AnswerCard(response: lastResponse)
                    }
                }
            }
            
            // Where you type the number
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
                TextField("", text: $userEntry)
                .keyboardType(.numberPad)
                .opacity(0)
                .font(.system(size: 24))
                .focused($isFocused)
                .padding([.leading], 3)
                .onAppear {
                    isFocused = true
                }
                .onChange(of: userEntry, initial: false) { _, currentNumber in
                    
                    userEntryArray = userEntry.map{String($0)}
                    
                    if currentNumber.count == 10 {
                        handleResponse()
                    }
                }
            }
        }
        .onAppear {
            contacts.shuffle()
        }
    }
    
}

struct QuizActiveView_Previews: PreviewProvider {
    
    static var previews: some View {
        QuizActiveView(contacts: Contact.sampleData, responses: .constant(Response.sampleData), quizIsFinished: .constant(false))
    }
}

