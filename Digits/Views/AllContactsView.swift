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
    
    @State var groupedContacts: [String: [Contact]] = [:]
    
    var body: some View {
        List {
            // Nothing in the search bar: divide the results into sections
            if searchText.isEmpty {
                ForEach(groupedContacts.keys.sorted(), id: \.self) {key in
                    Section(header: Text(key)) {
                        // Works, but very slow, do NOT use.
                        ForEach($contacts) {$contact in
                            if contact.name.prefix(1) == key {
                                MiniContactCard(contact: $contact)
                            }
                        }
                    }
                }
            }
            // If the user enters something in the search bar, don't sort by sections
            else {
                ForEach($contacts) {$contact in
                    if contact.name.uppercased().contains(searchText.uppercased()){ // case insensitive
                        MiniContactCard(contact: $contact)
                    }
                }
            }
        }
        // Sort the contacts array into a dictionary
        .onAppear {
            groupedContacts = Dictionary(
                grouping: contacts,
                by: { $0.name.prefix(1).uppercased() }
            ).mapValues{$0.sorted()}
        }
        // Search bar
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .navigationTitle("Select Contacts")
    }
}

struct AllContactsView_Previews: PreviewProvider {
    static var previews: some View {
        AllContactsView(contacts: .constant(Contact.sampleData))
    }
}
