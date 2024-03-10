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
        NavigationStack {
            List {
                // Make sections for each number type
                ForEach($contact.numbers) { $number in
                    
                    Section(header: Text(number.type)) {
                        TextField("Phone number", text: $number.editingNumber)
                            .bold()
                            .onChange(of: number.editingNumber) { _, newValue in
                                if newValue.count == 10 {
                                    number.number = number.editingNumber
                                }
                            }
                        HStack {
                            Text("Formatted: ")
                            Spacer()
                            Text(number.editingNumber.count == 10 ? number.numberFull : "Please enter 10 digits")
                        }
                    }
                }
            }
            .navigationTitle(contact.name)
        }
    }
}

struct EditContactSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditContactSheet(contact: .constant(Contact.sampleData[0]))
    }
}
