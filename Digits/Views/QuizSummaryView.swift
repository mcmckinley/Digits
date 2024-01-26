//
//  QuizSummaryView.swift
//  Digits
//
//  Created by Michael McKinley on 1/26/24.
//

import SwiftUI

struct QuizSummaryView: View {
    let responses: [Response]
    @Binding var quizIsFinished: Bool
    @Environment(\.dismiss) private var dismiss
    
    var numCorrect: Int {
        responses.filter {$0.isCorrect}.count
    }
    
    var accuracy: Int {
        Int(100 * numCorrect/responses.count)
    }
    
    var message: String {
        if      accuracy == 100 { return "Perfect!" }
        else if accuracy > 80 { return "Good job!" }
        else if accuracy > 60 { return "Room to improve" }
        else if accuracy > 40 { return "Better luck next time" }
        else                  { return "Yikes... try again?"}
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    var rectangleColor: Color {
        if colorScheme == .light {
            print("CS: ", colorScheme)
            return Color(red: 0.97, green: 0.97, blue: 0.97)
        } else {
            return Color(red: 0.1, green: 0.1, blue: 0.1)
        }
    }
    
    var settingsColor: Color {
        if colorScheme == .light {
            return Color(red: 0.7, green: 0.7, blue: 0.7)
        }
        return Color(red: 0.3, green: 0.3, blue: 0.3)

    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(message)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Text("Results:")
                .font(.headline)
            HStack (spacing: 0){
                Text("\(numCorrect)/\(responses.count)")
                    .fontWeight(.bold)
                Text(" correct answers")
            }
            HStack (spacing: 0){
                Text("\(accuracy)%")
                    .fontWeight(.bold)
                Text(" accuracy")
            }
            .padding([.bottom], 12)
        }
        .frame(maxWidth: .infinity)
        .frame(width: UIScreen.main.bounds.width - 80)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(rectangleColor)
        )
        HStack {
            Button(action: {
                dismiss()
            }) {
                Text("Home")
                    .bold()
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 16)
                    .padding([.leading, .trailing], 51)
                    .background(settingsColor)
                    .cornerRadius(10)
                
            }
            Button(action: {
                quizIsFinished = false
            }) {
                Text("New Quiz")
                    .bold()
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 16)
                    .padding([.leading, .trailing], 36)
                    .background(Color.blue)
                    .cornerRadius(10)
                
            }
        }
    }
}

#Preview {
    QuizSummaryView(responses: Response.sampleData, quizIsFinished: .constant(true))
}

