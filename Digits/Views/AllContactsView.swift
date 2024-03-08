//
//  AllContactsView.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      The user may have hundreds of contacts and only want to be quizzed on a few of them. Most contacts will be hidden. This screen shows which contacts are shown and which are hidden.

import SwiftUI

struct AllContactsView: View {
    @Binding var contacts: [Contact]
    
    @State private var searchText = ""
    /*
    var body: some View {
        NavigationStack {
            List {
                ForEach($contacts) { $contact in
                    /*
                    NavigationLink {
                        Text(contact.name)
                    } label: {
                        Text(contact.name)
                    }
                    */
                    
                    ContactCard(contact: $contact)
                    
                    
                }
            }
            //.searchable(text: $searchText)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("All Contacts")
        }
    }
    */
    
    
    //var inputArray: [String] = contacts
    
    @State var groupedArray: [String: [Contact]] = [:]
    var body: some View {
        List {
            ForEach(groupedArray.keys.sorted(), id: \.self) {key in
                Section(header: Text(key)) {
                    
                    // Works, but very slow, do NOT use.
                    ForEach($contacts) {$contact in
                        if contact.name.prefix(1) == key && (searchText == "" || contact.name.contains(searchText)){
                            MiniContactCard(contact: $contact)
                        }
                    }       
                }
            }
        }
        
        // TODO: Sort the contact dictionary so that empty keys are ignored.
        // This will require that groupedArray be updated based on searchText changing.
        // Maybe create a new function called sortContacts
        
        // Sort the contacts into a dictionary, where each key corresponds to their first initial.
        .onAppear {
            groupedArray = Dictionary(
                grouping: contacts,
                by: { $0.name.prefix(1).uppercased() }
            ).mapValues{$0.sorted()}
        }
        // Search bar
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .navigationTitle("All Contacts")
    }
}

struct AllContactsView_Previews: PreviewProvider {
    static var previews: some View {
        AllContactsView(contacts: .constant(Contact.sampleData))
    }
}
