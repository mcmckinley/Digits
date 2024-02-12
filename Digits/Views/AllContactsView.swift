//
//  AllContactsView.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      The user may have hundreds of contacts and only want to be quizzed on a few of them. Most contacts will be hidden. This screen shows which contacts are shown and which are hidden.

import SwiftUI

struct AllContactsView: View {
    @Binding var contacts: [Contact]
    
    var body: some View {
        Form {
            Section(header: Text("contacts to show in app")) {
                ForEach($contacts) { $contact in
                    if contact.allowed {
                        HStack {
                            Text(contact.name)
                            Spacer()
                            Button(action : {
                                contact.enabled = false
                                contact.allowed = false
                            }) {
                                Image(systemName: "minus.circle.fill")
                            }
                        }
                    }
                }
            }
            Section(header: Text("contacts to ignore")) {
                ForEach($contacts) { $contact in
                    if !contact.allowed {
                        HStack {
                            Text(contact.name)
                            Spacer()
                            Button(action : {
                                contact.allowed = true
                                contact.enabled = true
                            }) {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                    }
                }
            }
            
        }
    }
}

struct AllContactsView_Previews: PreviewProvider {
    static var previews: some View {
        AllContactsView(contacts: .constant(Contact.sampleData))
    }
}
