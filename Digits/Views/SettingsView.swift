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
        Form {
            Section(header: Text("Enabled contacts")) {
                ForEach($contacts) { $contact in
                    if contact.enabled {
                        Button(action : {
                            
                        }){
                            HStack {
                                Text(contact.name)
                                    .foregroundColor(.black)
                                Spacer()
                                Button(action : {
                                    contact.enabled = false
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                }
                            }
                        }
                    }
                }
            }
            Section(header: Text("Disabled contacts")) {
                ForEach($contacts) { $contact in
                    if !contact.enabled && contact.allowed {
                        HStack {
                            Text(contact.name)
                            Spacer()
                            Button(action : {
                                contact.enabled = true
                            }) {
                                Image(systemName: "plus.circle.fill")
                            }
                        }
                    }
                }
            }
            Section(header: Text("Additional Settings")){
                HStack {
                    Text("See All Contacts")
                    Spacer()
                    Button(action : {
                        isDisplayingAllContactsSheet = true;
                    }) {
                        Image(systemName: "chevron.right")
                    }
                }
            }
        }
        .sheet(isPresented: $isDisplayingAllContactsSheet) {
            AllContactsView(contacts: $contacts)
        }
        /*
        .sheet(isPresented: $isDisplayingEditContactSheet) {
            EditContactSheet(contact: $selectedContact, isDisplayingEditContactSheet: $isDisplayingEditContactSheet)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            $isDisplayingEditContactSheet = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            $isDisplayingEditContactSheet = false
                            scrum = editingScrum
                        }
                    }
                }
        }
         */
         
    }
}

struct EditQuizSheet_Previews: PreviewProvider {
    static var previews: some View {
        EditQuizSheet(contacts: .constant(Contact.sampleData))
    }
}
