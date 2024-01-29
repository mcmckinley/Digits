//
//  EditContactsView.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      - Shows all visible contacts. Can click on a contact to edit, swipe left to delete, or press "+" to create a new one.
//      - This is where the app requests access to the user's contacts.

import SwiftUI
import Contacts


struct EditContactsView: View {
    @Binding var contacts: [Contact]

    @State private var isPresentingAllContactsSheet: Bool = false
    @State private var isPresentingNewContactSheet: Bool = false
    
    @State private var showAlert = false
    
    func removeContact(at offsets: IndexSet) {
        contacts.remove(atOffsets: offsets)
    }
    
    func requestContactsAccess() {
        
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, error) in
            if granted {
                // Access granted, you can now perform any additional setup or navigate to your main view
                print("Access to contacts granted.")
                contacts = []
                fetchContacts()
            } else {
                // Handle the case where access was not granted
                print("Access to contacts was not granted.")
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
                if ($contacts.filter{$0.allowed.wrappedValue}).count > 0 {
                    ForEach($contacts.filter{$0.allowed.wrappedValue}) { $contact in
                        NavigationLink(destination: EditContactSheet(contact: $contact)) {
                            Text(contact.name)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        removeContact(at: indexSet)
                    })
                } else {
                    Text("Click the Load From Device button to import contacts. Then, click on See Hidden Contacts to choose contacts to see in the app.")
                }
            }
            .toolbar {
                Button(action: {
                    isPresentingNewContactSheet = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .navigationTitle("Edit contacts")
        
            HStack{
                // Load From Device button
                Button(action: {
                     showAlert = true
                }) {
                    Text("Load from device")
                        .bold()
                        .foregroundColor(.white)
                        .padding([.top, .bottom], 16)
                        .padding([.leading, .trailing], 12)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Load contacts from device"),
                        message: Text("This will reset your data. Continue?"),
                        primaryButton: .cancel(Text("Cancel")),
                        secondaryButton: .default(Text("Continue"), action: {
                            requestContactsAccess()
                        })
                    )
                }
                // See Hidden Contacts button
                Button(action: {
                    isPresentingAllContactsSheet = true
                }) {
                    Text("See hidden contacts")
                        .bold()
                        .foregroundColor(.white)
                        .padding([.top, .bottom], 16)
                        .padding([.leading, .trailing], 12)
                        .background(Color.gray)
                        .cornerRadius(10)
                }
            }
        }
        .sheet(isPresented: $isPresentingNewContactSheet){
            NewContactSheet(contacts: $contacts, isPresentingNewContactSheet: $isPresentingNewContactSheet)
        }
        .sheet(isPresented: $isPresentingAllContactsSheet) {
            AllContactsView(contacts: $contacts)
        }
    }
}

struct EditQuizView_Previews: PreviewProvider {
    static var previews: some View {
        EditContactsView(contacts: .constant(Contact.sampleData))
    }
}
