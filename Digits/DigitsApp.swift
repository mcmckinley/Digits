//
//  DigitsApp.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      - Quizzes a user on their knowledge of their contact's phone numbers.

import SwiftUI
import Contacts

@main
struct DigitsApp: App {
    @StateObject private var store = ContactStore()
    @State private var errorWrapper: ErrorWrapper?
    

    
    var body: some Scene {
        WindowGroup {
            HomeView(contacts: $store.contacts){
                Task {
                    do {
                        try await store.save(contacts: store.contacts)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Digits will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper) {
                store.contacts = Contact.sampleData
            } content: { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}

