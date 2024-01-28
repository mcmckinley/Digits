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
    
    @State private var isDisplayingEditContactSheet: Bool = false
    
    var body: some View {
        
        NavigationStack {
            List($contacts.filter{$0.allowed.wrappedValue}) { $contact in
                NavigationLink(destination: EditContactSheet(contact: $contact)) {
                    Text(contact.name)
                }
            }
            .toolbar {
                Button(action: {
                    isDisplayingEditContactSheet = true
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
        .sheet(isPresented: $isDisplayingEditContactSheet){
            NewContactSheet(contacts: $contacts, isPresentingNewContactSheet: $isDisplayingEditContactSheet)
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
