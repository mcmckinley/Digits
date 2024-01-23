//
//  QuizView.swift
//  Digits
//
//  Created by Michael McKinley on 1/16/24.
//

import SwiftUI

struct QuizView: View {
    let contacts: [Contact]
    
    @State var enteredNum: String = ""
    
    var body: some View {
        
        /*
        let testContact = contacts[0]
        
        TextField("Enter \(testContact.name)'s number:", text: $enteredNum)
                    .keyboardType(.numberPad)
                    .onReceive(Just(enteredNum)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.enteredNum = filtered
                        }
                    }
         */
        Text("Why hello")
        
    }
}

#Preview {
    QuizView(contacts: Contact.sampleData)
}

