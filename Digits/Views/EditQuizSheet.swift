//
//  EditQuizSheet.swift
//  Digits
//
//  Created by Michael McKinley on 1/22/24.
//

import SwiftUI


struct EditQuizSheet: View {
    @Binding var contacts: [Contact]
    @Binding var time: Double
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                HStack {
                    Slider(value: $time, in: 5...60, step: 1) {
                        Text("Length")
                    }
                    Spacer()
                    Text("\(time) seconds")
                }
            }
            Section(header: Text("Enabled contacts")) {
                ForEach($contacts) { $contact in
                    if contact.enabledForQuiz {
                        HStack {
                            Text(contact.name)
                            Spacer()
                            Button(action : {
                                contact.enabledForQuiz = false
                            }) {
                                Image(systemName: "minus.circle.fill")
                            }
                        }
                    }
                }
            }
            Section(header: Text("Disabled contacts")) {
                ForEach($contacts) { $contact in
                    if !contact.enabledForQuiz {
                        HStack {
                            Text(contact.name)
                            Spacer()
                            Button(action : {
                                contact.enabledForQuiz = true
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
                        AllContactsView(contacts: $contacts)
                    }) {
                        Image(systemName: "chevron.right")
                    }
                }
            }
        }
    }
}

struct EditQuizSheet_Previews: PreviewProvider {
    static var time: Double = 20.0
    static var previews: some View {
        EditQuizSheet(contacts: .constant(Contact.sampleData), time: .constant(time))
    }
}
