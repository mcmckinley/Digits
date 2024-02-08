//
//  AppInfoSheet.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      Shows info about the app: credits, link to repository, bug reporting

import SwiftUI

struct AppInfoSheet: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Credits")
                .bold()
                .font(.system(size: 24.0))
                .padding([.top], 10)
            Text("Michael McKinley - Developer")
                .font(.system(size: 18.0))

            Text("Eric McKinley - Concept")
                .font(.system(size: 18.0))
            
            Text("More info")
                .bold()
                .font(.system(size: 24.0))
                .padding([.top], 10)
            Text("https://mckinleydev.com/digits-quiz/")
                .font(.system(size: 18.0))

            Text("Report bugs")
                .bold()
                .font(.system(size: 24.0))
                .padding([.top], 10)
            Text("Your feedback is highly appreciated.\nPlease share any issues you find via email at mxmckinley@gmail.com")
                .font(.system(size: 18.0))

            Text("Developers: ")
                .bold()
                .font(.system(size: 18.0))
            Text("Feel free to open a pull request or submit issues. The repository can be found at https://github.com/mcmckinley/Digits")
                .font(.system(size: 18.0))
            
            Text("Privacy")
                .bold()
                .font(.system(size: 24.0))
                .padding([.top], 10)
            Text("Digits Quiz does not collect, store, or transmit any contact information to external servers. All contact data is processed locally on your device for the sole purpose of being used in quizzes.")
                .font(.system(size: 18.0))

            Spacer()
        }
        .padding([.leading, .trailing], 15)
        .padding([.top], 10)
    }
}

struct AppInfoSheet_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoSheet()
    }
}
