//
//  PhoneNumberFrameCard.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      - Provides the following frame for a US phone number: (___)___-____

import SwiftUI

struct PhoneNumberFrameCard: View {
    var body: some View {
        HStack(spacing: 0){
            Text("(")
                .font(.system(size: 36))
                .fontDesign(.monospaced)
                .padding(3)
            Underscore()
            Underscore()
            Underscore()
            Text(")")
                .font(.system(size: 36, design: .rounded))
                .fontDesign(.monospaced)
            Underscore()
            Underscore()
            Underscore()
            Text("-")
                .font(.system(size: 28, design: .rounded))
                .fontDesign(.monospaced)
            Underscore()
            Underscore()
            Underscore()
            Underscore()
            Spacer()
        }
        .foregroundColor(.gray)
    }
}

struct Underscore: View {
    var body: some View {
        VStack {
            Spacer().frame(height: 16)
            Text("_")
                .font(.system(size: 32, design: .rounded))
                .fontDesign(.monospaced)
                .padding(3)
        }
    }
}

struct PhoneNumberFrameCard_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberFrameCard()
    }
}
