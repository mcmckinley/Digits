//
//  PhoneNumberFrameCard.swift
//  Digits
//
//  Created by Michael McKinley on 1/23/24.
//

import SwiftUI

struct PhoneNumberFrameCard: View {
    var body: some View {
        HStack(spacing: 0){
            Text("(")
                .font(.system(size: 32, design: .rounded))
                .padding(3)
            VStack {
                Spacer().frame(height: 16)
                Text("_")
                    .font(.system(size: 40, design: .rounded))
                    .padding(5)
            }
            VStack {
                Spacer().frame(height: 16)
                Text("_")
                    .font(.system(size: 40, design: .rounded))
                    .padding(5)

            }
            VStack {
                Spacer().frame(height: 16)
                Text("_")
                    .font(.system(size: 40, design: .rounded))
                    .padding(5)

            }
            Text(")")
                .font(.system(size: 32, design: .rounded))
            VStack {
                Spacer().frame(height: 16)
                Text("_")
                    .font(.system(size: 40, design: .rounded))
                    .padding(5)
            }
            VStack {
                Spacer().frame(height: 16)
                Text("_")
                    .font(.system(size: 40, design: .rounded))
                    .padding(5)

            }
            VStack {
                Spacer().frame(height: 16)
                Text("_")
                    .font(.system(size: 40, design: .rounded))
                    .padding(5)
            }
            Text("-")
                .font(.system(size: 32, design: .rounded))
            VStack {
                Spacer().frame(height: 16)
                Text("_")
                    .font(.system(size: 40, design: .rounded))
                    .padding(5)
            }
            VStack {
                Spacer().frame(height: 16)
                Text("_")
                    .font(.system(size: 40, design: .rounded))
                    .padding(5)

            }
            VStack {
                Spacer().frame(height: 16)
                Text("_")
                    .font(.system(size: 40, design: .rounded))
                    .padding(5)
            }
            VStack {
                Spacer().frame(height: 16)
                Text("_")
                    .font(.system(size: 40, design: .rounded))
                    .padding(5)
            }
            Spacer()
        }
        .foregroundColor(.gray)
    }
}

struct PhoneNumberFrameCard_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberFrameCard()
            .previewLayout(.fixed(width: 400, height: 50))
    }
}
