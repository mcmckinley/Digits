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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    
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

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Request contact access when the app launches
        requestContactsAccess()
        return true
    }
    
    func requestContactsAccess() {
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, error) in
            if granted {
                // Access granted, you can now perform any additional setup or navigate to your main view
                print("Access to contacts granted.")
                fetchContacts()
            } else {
                // Handle the case where access was not granted
                print("Access to contacts was not granted.")
            }
        }
    }
}

func fetchContacts() {
    let store = CNContactStore()
    
    let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
    let request = CNContactFetchRequest(keysToFetch: keysToFetch as [CNKeyDescriptor])
    
    do {
        try store.enumerateContacts(with: request) { (contact, stop) in
            // Access the contact information
            let firstName = contact.givenName
            let lastName = contact.familyName
            let phoneNumbers = contact.phoneNumbers.map { $0.value.stringValue }
            //let phoneNumbers = contact.phoneNumbers[0]

            
            // Use the contact information as needed
            print("Name: \(firstName) \(lastName), Phone Numbers: \(phoneNumbers)")
        }
    } catch {
        // Handle the error
        print("Error fetching contacts: \(error)")
    }
}
