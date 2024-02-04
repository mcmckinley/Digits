//
//  QuizActiveView.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      - This is where the user takes the quiz. A prompt is given, asking the user to enter a contact's digits. The prompt flashes green and moves on to the next question if a correct answer is given. If an incorrect answer is given, the prompt flashes red and allows the user to answer again.

import SwiftUI
import Foundation

struct QuizActiveView: View {
    @State var contacts: [Contact]
    
    @State private var contactIndex: Int = 0
    
    @Binding var responses: [Response]
    
    @Binding var quizIsFinished: Bool

    // The currently entered number by the user
    @State private var userEntry: String = ""
    // Same as userEntry, but split into characters for parsing
    @State private var userEntryArray: [String] = []
    
    // Automatically selects the textfield.
    @FocusState private var isFocused: Bool
    
    // Dark mode / light mode
    @Environment(\.colorScheme) var colorScheme

    // Red and green flashing after responses
    @State var redFeedback: Double = 0
    @State var greenFeedback: Double = 0
    @State var blueFeedback: Double = 0
    
    private func updateColors(){
        redFeedback   = colorScheme == .light ? 0 : 1
        blueFeedback  = colorScheme == .light ? 0 : 1
        greenFeedback = colorScheme == .light ? 0 : 1
    }
    
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
    
    // Handle a response, either when submitted or skipped
    private func handleResponse(skipped: Bool = false){
        if skipped {
            userEntry = "??????????"
        }

        responses.append(
            Response(answer: contacts[contactIndex].number,
                     userResponse: userEntry,
                     contactName: contacts[contactIndex].name,
                     wasSkipped: skipped
            )
        )
        userEntry = ""
        userEntryArray = []
        
        if let lastResponse = responses.last {
            // Give the user feedback
            if lastResponse.isCorrect {
                feedback(correct: true)
            } else {
                feedback(correct: false)
            }
            // Increment the contactIndex
            if lastResponse.isCorrect || lastResponse.wasSkipped {
                if contactIndex == contacts.count-1 {
                    quizIsFinished = true
                } else {
                    contactIndex+=1
                }
            }
        }
    }
    
    

    var body: some View {
        VStack {
            // Adjust everything down a bit
            Spacer().frame(height: 120)

            HStack {
                Spacer().frame(width: 10)
                Button (action: {
                    handleResponse(skipped:true)
                }) {
                    Text("Skip")
                        .foregroundColor(.red)
                        .font(.system(size: 24))
                }
                Spacer()
            }
            // Enter <person>'s digits
            HStack {
                Spacer().frame(width: 10)
                Text("Enter \(contacts[contactIndex].name)'s digits:")
                    .font(.title)
                    .bold()
                Spacer()
            }
            // Responsive feedback
            .foregroundColor(Color(red: redFeedback, green: greenFeedback, blue: blueFeedback))
            .onChange(of: colorScheme, initial: true) {
                updateColors()
            }

            
            // The number you just entered: invisible if your previous answer was correct
            HStack {
                if let lastResponse = responses.last {
                    if !lastResponse.isCorrect && !lastResponse.wasSkipped {
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

