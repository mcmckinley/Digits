//
//  MainView.swift
//  Digits
//
//  Created by Michael McKinley on 1/16/24.
//

import SwiftUI


struct MainView: View {
    let contacts: [Contact]
    
    var body: some View {
        TabView {
            ContactView(contacts: contacts)
                .tabItem {
                    Label("Contacts", systemImage: "person.crop.circle.fill")
                }
            QuizView(contacts: contacts)
                .tabItem {
                    Label("Quiz", systemImage: "play")
                }
        }
    }
}

#Preview {
    MainView(contacts: Contact.sampleData)
}
