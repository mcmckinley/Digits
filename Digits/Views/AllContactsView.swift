//
//  AllContactsView.swift
//  Digits
//
//  Created by Michael McKinley on 1/22/24.
//

import SwiftUI

struct AllContactsView: View {
    @Binding var contacts: [Contact]
    
    var body: some View {
        Form {
            ForEach(contacts) {contact in
                
                Text(contact.name)
                
            }
            
        }
    }
}

struct AllContactsView_Previews: PreviewProvider {
    static var previews: some View {
        AllContactsView(contacts: .constant(Contact.sampleData))
    }
}
