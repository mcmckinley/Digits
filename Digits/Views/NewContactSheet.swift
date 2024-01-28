//
//  NewContactSheet.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      - Sheet for creating a new contact
//
//

import SwiftUI

struct NewContactSheet: View {
    @State private var newContact = Contact.emptyContact
    @Binding var contacts: [Contact]
    @Binding var isPresentingNewContactSheet: Bool
    
    
    var body: some View {
        NavigationStack {
            EditContactSheet(contact: $newContact)
                .toolbar {
                    // Cancel
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingNewContactSheet = false
                        }
                    }
                    // Save
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            contacts.append(newContact)
                            isPresentingNewContactSheet = false
                        }
                    }
                }
        }
        .onAppear(){
            newContact.enabled = true
            newContact.allowed = true
        }
    }
}

#Preview {
    NewContactSheet(contacts: .constant(Contact.sampleData), isPresentingNewContactSheet: .constant(true))
}
