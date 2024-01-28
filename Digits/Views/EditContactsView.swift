//
//  EditContactsView.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      - Shows all visible contacts. Can click on a contact to edit, swipe left to delete, or press "+" to create a new one

import SwiftUI


struct EditContactsView: View {
    @Binding var contacts: [Contact]

    @State private var isPresentingAllContactsSheet: Bool = false
    @State private var isPresentingNewContactSheet: Bool = false
    
    func removeContact(at offsets: IndexSet) {
        contacts.remove(atOffsets: offsets)
    }
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach($contacts.filter{$0.allowed.wrappedValue}) { $contact in
                    NavigationLink(destination: EditContactSheet(contact: $contact)) {
                        Text(contact.name)
                    }
                }
                .onDelete(perform: { indexSet in
                    removeContact(at: indexSet)
                })
            }
            .toolbar {
                Button(action: {
                    isPresentingNewContactSheet = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .navigationTitle("Edit contacts")
        
            Button(action: {
                isPresentingAllContactsSheet = true
            }) {
                Text("See hidden contacts")
                    .bold()
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 16)
                    .padding([.leading, .trailing], 40)
                    .background(Color.gray)
                    .cornerRadius(10)
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
