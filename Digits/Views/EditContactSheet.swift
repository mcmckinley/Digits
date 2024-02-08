//
//  EditContactSheet.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      - Sheet for editing a single contact

import SwiftUI


struct EditContactSheet: View {
    @Binding var contact: Contact
    
    var body: some View {
        Form {
            Section(header: Text("Contact name")){
                TextField("Contact name", text: $contact.name)
            }
            Section(header: Text("Contact's digits")){
                TextField("Phone number", text: $contact.editingNumber)
                    .bold()
                    .onChange(of: contact.editingNumber) { _, newValue in
                        if newValue.count == 10 {
                            contact.number = contact.editingNumber
                        }
                    }
                HStack {
                    Text("Formatted: ")
                    Spacer()
                    Text(contact.editingNumber.count == 10 ? contact.numberFull : "Please enter 10 digits")
                }
            }
        }
    }
}

struct EditContactSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditContactSheet(contact: .constant(Contact.sampleData[0]))
    }
}
