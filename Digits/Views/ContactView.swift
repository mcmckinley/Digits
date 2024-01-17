//
//  ContentView.swift
//  Digits
//
//  Created by Michael McKinley on 1/16/24.
//

import SwiftUI

struct ContactView: View {
    let contacts: [Contact]
    
    var body: some View {
        NavigationStack {
            List(contacts) { contact in
                ContactCard(contact: contact)
            }
            .navigationTitle("All Contacts")
        }
    }
}

#Preview {
    ContactView(contacts: Contact.sampleData)
}
