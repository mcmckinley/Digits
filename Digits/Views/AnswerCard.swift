//
//  answerCard.swift
//  Digits
//
//  Created by Michael McKinley on 1/23/24.
//

import SwiftUI
import Foundation

struct AnswerCard: View {
    let answer: String
    let userResponse: String
    
    var answerArray: [String] {
        answer.map{String($0)}
    }
    var userResponseArray: [String] {
        userResponse.map{String($0)}
    }
    
    var answerIsCorrect: Bool {
        userResponse == answer
    }
    
    var rightAnswerAt: [Bool] {
        zip(answerArray, userResponseArray).map { $0 == $1 }
    }

    
    
    
    
    var body: some View {
        //if answerIsCorrect {
            ZStack {
                HStack (spacing: 0){
                    Spacer().frame(width: 32)
                    // Not sure how this next line works, needed openAI to help me here
                    ForEach(Array(userResponseArray.enumerated()), id: \.0) { index, char in
                        Text(char)
                            .font(.system(size: 30))
                            .padding([.trailing], 7)
                            .fontDesign(.monospaced)
                            .foregroundColor(rightAnswerAt[index] ? .green : .red)

                        if index == 2 {
                            Spacer().frame(width: 23)
                        }
                        if index == 5 {
                            Spacer().frame(width: 18)
                        }
                    }
                    Spacer()
                }
                
                PhoneNumberFrameCard()
            }
            
        //}
        
        
    }
}

struct AnswerCard_Previews: PreviewProvider {
    
    
    static var previews: some View {
        AnswerCard(answer: "1234567890", userResponse: "1234567890")
            .previewLayout(.fixed(width: 400, height: 120))
    }
}
