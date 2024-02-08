//
//  AnswerCard.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description
//      - Shows the user which digits they answered correctly and incorrectly.

import SwiftUI
import Foundation

struct AnswerCard: View {
    let response: Response
    
    var body: some View {
        ZStack {
            HStack (spacing: 0){
                Spacer().frame(width: 32)
                ForEach(Array(response.userResponse.enumerated()), id: \.0) { index, char in
                    Text(response.userResponseArray[index])
                        .foregroundColor(response.rightAnswerAt[index] ? .green : .red)
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
