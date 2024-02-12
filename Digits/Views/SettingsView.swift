//
//  SettingsView.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      - Shows all visible contacts. Can click on a contact to edit, swipe left to delete, or press "+" to create a new one.
//      - This is where the app requests access to the user's contacts.

import SwiftUI
import Contacts

struct SettingsView: View {
    @Binding var contacts: [Contact]

    @State private var isPresentingAllContactsSheet: Bool = false
    @State private var isPresentingNewContactSheet: Bool = false
    
    @State private var loadDataAlert = false
    @State private var clearDataAlert = false

    func removeContact(at offsets: IndexSet) {
        contacts.remove(atOffsets: offsets)
    }
    
    func requestContactsAccess() {
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, error) in
            if granted {
                contacts = []
                fetchContacts()
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
                var phoneNumber: String = phoneNumbers.count > 0 ? phoneNumbers[0] : "0"
                
                phoneNumber = phoneNumber.replacingOccurrences(of: "+1", with: "")
                    .replacingOccurrences(of: "(", with: "")
                    .replacingOccurrences(of: ")", with: "")
                    .replacingOccurrences(of: "-", with: "")
                    .replacingOccurrences(of: " ", with: "")
                
                if phoneNumber.count == 10 && firstName.count > 0 {
                    // Switch to the main thread to modify contacts, which is a published variable
                    DispatchQueue.main.async {
                        contacts.append(Contact(name: firstName + " " + lastName, number: phoneNumber))
                    }
                }
            }
        } catch {
            print("Error fetching contacts: \(error)")
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    // Contact names
                    ForEach($contacts.filter{$0.allowed.wrappedValue}) { $contact in
                        NavigationLink(destination: EditContactSheet(contact: $contact)) {
                            Text(contact.name)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        removeContact(at: indexSet)
                    })
                    // See All Contacts button
                    NavigationLink(destination: AllContactsView(contacts: $contacts)){
                        Text("See all contacts (\(contacts.count))")
                    }
                }
                
                // Create New Contact button
                Section {
                    Button(action : {
                        isPresentingNewContactSheet = true
                    }) {
                        HStack{
                            Text("Create New Contact")
                            Spacer()
                            Image(systemName: "plus")
                        }
                    }
                }
                
                // Load From Device button
                Button(action: {
                     loadDataAlert = true
                }) {
                    Text("Load From Device")
                }
                .alert(isPresented: $loadDataAlert) {
                    Alert(
                        title: Text("Load contacts from device"),
                        message: Text("This will reset your contact data. Continue?"),
                        primaryButton: .cancel(Text("Cancel")),
                        secondaryButton: .default(Text("Continue"), action: {
                            requestContactsAccess()
                        })
                    )
                }
                
                // Clear Data button
                Button(action: {
                     clearDataAlert = true
                }) {
                    Text("Clear Data")
                        .foregroundColor(.red)
                }
                .alert(isPresented: $clearDataAlert) {
                    Alert(
                        title: Text("Clear app data"),
                        message: Text("This will clear the app's data, including contacts that you have created. Continue?"),
                        primaryButton: .cancel(Text("Cancel")),
                        secondaryButton: .default(Text("Continue"), action: {
                            contacts = []
                        })
                    )
                }
            }
            // Additional option to create a contact: plus symbol in top right
            .toolbar {
                Button(action: {
                    isPresentingNewContactSheet = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .navigationTitle("Settings")
        }
        .sheet(isPresented: $isPresentingNewContactSheet){
            NewContactSheet(contacts: $contacts, isPresentingNewContactSheet: $isPresentingNewContactSheet)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(contacts: .constant(Contact.sampleData))
    }
}
