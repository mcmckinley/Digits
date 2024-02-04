//
//  ContactCard.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      A simple display of a contact's name and digits, as well as a button to toggle whether the contact will show up in the quiz

import SwiftUI

struct ContactCard: View {
    @Binding var contact: Contact
    
    // Used for disabled contacts
    static let darkGrey = Color(red: 0.5, green: 0.5, blue: 0.5)
    
    var body: some View {
        // Formatting for enabled contacts
        if contact.enabled {
            HStack {
                Text(contact.name)
                    .font(.system(size: 20))
                    .bold()
                
                Spacer()
                Text(contact.numberFull)
                    .bold()
                Button(action: {
                    contact.enabled.toggle()
                }) {
                    Image(systemName: "minus.circle.fill")
                }
            }
            .padding(5)
        } else {
            // Formatting for greyed out (disabled) contacts
            HStack {
                HStack {
                    Text(contact.name)
                        .font(.system(size: 18))
                        .bold()
                    Spacer()
                    Text(contact.numberFull)
                        .bold()
                }
                .foregroundColor(ContactCard.darkGrey)
                Button(action: {
                    contact.enabled.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                }
            }
            .padding(5)
            
        }
 
    }
    
}

struct ContactCard_Previews: PreviewProvider {
    static var contact: Contact = Contact.sampleData[0]
    
    static var previews: some View {
        ContactCard(contact: .constant(contact))
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
