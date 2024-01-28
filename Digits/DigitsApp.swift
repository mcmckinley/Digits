//
//  DigitsApp.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      - Quizzes a user on their knowledge of their contact's phone numbers.

import SwiftUI

@main
struct DigitsApp: App {
    @State var contacts: [Contact] = Contact.sampleData
    var body: some Scene {
        WindowGroup {
            HomeView(contacts: $contacts)
        }
    }
}
