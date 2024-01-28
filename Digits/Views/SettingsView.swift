//
//  EditQuizSheet.swift
//  Digits
//
//  Created by Michael McKinley on 1/22/24.
//

import SwiftUI


struct EditQuizSheet: View {
    @Binding var contacts: [Contact]

    
    @State var isDisplayingAllContactsSheet: Bool = false
    
    
    var body: some View {
        
        NavigationStack {
            List($contacts.filter{$0.allowed.wrappedValue}) { $contact in
                NavigationLink(destination: EditContactSheet(contact: $contact)) {
                    Text(contact.name)
                }
            }
            .navigationTitle("Edit contacts")
        
            Button(action: {
                isDisplayingAllContactsSheet = true
            }) {
                Text("See hidden contacts")
                    .bold()
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 16)
                    .padding([.leading, .trailing], 40)
                    .background(Color.gray)
                    .cornerRadius(10)
                
            }
        }
        
        .sheet(isPresented: $isDisplayingAllContactsSheet) {
            AllContactsView(contacts: $contacts)
        }
    }
}

struct EditQuizSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditQuizSheet(contacts: .constant(Contact.sampleData))
    }
}
