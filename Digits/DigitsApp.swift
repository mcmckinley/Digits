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
    //@State var contacts: [Contact] = Contact.sampleData
    @StateObject private var store = ContactStore()
    
    var body: some Scene {
        WindowGroup {
            HomeView(contacts: $store.contacts){
                Task {
                    do {
                        try await store.save(contacts: store.contacts)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
