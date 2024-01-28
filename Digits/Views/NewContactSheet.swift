//
//  NewContactSheet.swift
//  Digits
//
//  Created by Michael McKinley on 1/28/24.
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
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            isPresentingNewContactSheet = false
                        }
                    }
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
