//
//  MiniContactCard.swift
//  Digits Quiz
//
//  Created by Michael McKinley
//

import SwiftUI

struct MiniContactCard: View {
    @Binding var contact: Contact
    
    // Used for disabled contacts
    static let darkGrey = Color(red: 0.5, green: 0.5, blue: 0.5)
    
    var body: some View {
        // Formatting for enabled contacts
        if contact.enabled {
            HStack {
                Text(contact.name)
                    .font(.system(size: 14))
                    .bold()
                Spacer()
                if contact.numbers.count == 0 {
                    Text(contact.numbers[0].number)
                        .font(.system(size: 14))
                        .lineLimit(1)  // Set the maximum number of lines to 1
                        .truncationMode(.tail)
                    Button(action: {
                        contact.allowed = false
                        contact.enabled = false

                    }) {
                        Image(systemName: "checkmark.circle.fill")
                    }
                }
            }
            .padding(5)
        } else {
            // Formatting for greyed out (disabled) contacts
            HStack {
                HStack {
                    Text(contact.name)
                        .font(.system(size: 14))
                        .bold()
                    Spacer()
                    if contact.numbers.count == 0 {
                        Text(contact.numbers[0].number)
                            .font(.system(size: 14))
                            .lineLimit(1)  // Set the maximum number of lines to 1
                            .truncationMode(.tail)
                    }
                }
                .foregroundColor(ContactCard.darkGrey)
                Button(action: {
                    contact.allowed = true
                    contact.enabled = true
                }) {
                    Image(systemName: "circle")
                }
            }
            .padding(5)
        }
    }
}

struct MiniContactCard_Previews: PreviewProvider {
    static var contact: Contact = Contact.sampleData[0]
    
    static var previews: some View {
        MiniContactCard(contact: .constant(contact))
            .previewLayout(.fixed(width: 400, height: 60))
    }
}

