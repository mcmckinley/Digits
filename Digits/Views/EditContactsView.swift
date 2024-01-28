//
//  EditQuizSheet.swift
//  Digits
//
//  Created by Michael McKinley on 1/22/24.
//

import SwiftUI


struct EditContactsView: View {
    @Binding var contacts: [Contact]

    @State var isDisplayingAllContactsSheet: Bool = false
    
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
                isDisplayingAllContactsSheet = true
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
        .sheet(isPresented: $isDisplayingAllContactsSheet) {
            AllContactsView(contacts: $contacts)
        }
    }
}

struct EditQuizView_Previews: PreviewProvider {
    static var previews: some View {
        EditContactsView(contacts: .constant(Contact.sampleData))
    }
}
