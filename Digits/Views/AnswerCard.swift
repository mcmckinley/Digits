//
//  answerCard.swift
//  Digits
//
//  Created by Michael McKinley on 1/23/24.
//

import SwiftUI
import Foundation

struct AnswerCard: View {
    let response: Response
    
    var body: some View {
        ZStack {
            HStack (spacing: 0){
                Spacer().frame(width: 32)
                // Not sure how this next line works, needed openAI to help me here
                ForEach(Array(response.userResponse.enumerated()), id: \.0) { index, char in
                    Text(response.userResponseArray[index])
                        .font(.system(size: 30))
                        .padding([.trailing], 7)
                        .fontDesign(.monospaced)
                        .foregroundColor(response.rightAnswerAt[index] ? .green : .red)
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
    }
}

struct AnswerCard_Previews: PreviewProvider {
    
    static var previews: some View {
        AnswerCard(response: Response.sampleData[0])
            .previewLayout(.fixed(width: 400, height: 120))
    }
}
