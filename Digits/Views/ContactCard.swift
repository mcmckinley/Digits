//
//  ContactCard.swift
//  Digits
//
//  Created by Michael McKinley on 1/16/24.
//

import SwiftUI

struct ContactCard: View {
    @Binding var contact: Contact
    
    var body: some View {
        HStack {
            Text(contact.name)
                .font(.title)
                .bold()
            Spacer()
            Text(contact.numberFull)
                .bold()
        }
        .padding(5)
    }
}

struct ContactCard_Previews: PreviewProvider {
    static var contact: Contact = Contact.sampleData[0]
    
    static var previews: some View {
        ContactCard(contact: .constant(contact))
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
