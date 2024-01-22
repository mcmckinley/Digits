//
//  ContentView.swift
//  Digits
//
//  Created by Michael McKinley on 1/16/24.
//

import SwiftUI

struct ContactView: View {
    @Binding var contacts: [Contact]
    @State private var isPresentingSettingsView = false
    @State private var timePerQuestion: Double = 8.0
    
    var body: some View {
        NavigationStack {
            List($contacts) { $contact in
                if contact.enabledForQuiz {
                    ContactCard(contact: $contact)
                }
            }
            .navigationTitle("Digits Quiz")
        }
        
        HStack {
            Button(action: {
                print("Settings!")
                isPresentingSettingsView = true
            }) {
                Text("Settings")
                    .bold()
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 15)
                    .padding([.leading, .trailing], 61)
                    .background(Color.gray)
                    .cornerRadius(10)
                
            }
            
            Button(action: {
                print("Begin!")
            }) {
                Text("Begin")
                    .bold()
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 15)
                    .padding([.leading, .trailing], 70)
                    .background(Color.blue)
                    .cornerRadius(10)
                
            }
            
        }
        .sheet(isPresented: $isPresentingSettingsView) {
            EditQuizSheet(contacts: $contacts, time: $timePerQuestion)
        }
    }
}

#Preview {
    ContactView(contacts: .constant(Contact.sampleData))
}
