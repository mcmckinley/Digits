//
//  ContactCard.swift
//  Digits
//
//  Created by Michael McKinley on 1/16/24.
//

import SwiftUI

struct ContactCard: View {
    @Binding var contact: Contact
    
    @Environment(\.colorScheme) var colorScheme
    var darkGrey = Color(red: 0.5, green: 0.5, blue: 0.5)
    
    
    var body: some View {
        if contact.enabled {
            HStack {
                Text(contact.name)
                    .font(.title)
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
            HStack {
                HStack {
                    Text(contact.name)
                        .font(.system(size: 24))
                        .bold()
                    Spacer()
                    Text(contact.numberFull)
                        .bold()
                }
                .foregroundColor(darkGrey)
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
