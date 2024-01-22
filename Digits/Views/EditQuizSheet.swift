//
//  EditQuizSheet.swift
//  Digits
//
//  Created by Michael McKinley on 1/22/24.
//

import SwiftUI


struct QuizEditSheet: View {
    @Binding var contacts: [Contact]
    @Binding var time: Double
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                HStack {
                    Slider(value: $time, in: 5...60, step: 1) {
                        Text("Length")
                    }
                    .accessibilityValue("minutes")
                    Spacer()
                    Text("\(time) seconds")
                        .accessibilityHidden(true)
                }
            }
            Section(header: Text("Enabled contacts")) {
                ForEach($contacts) { $contact in
                    if contact.enabledForQuiz {
                        Text(contact.name)
                    }
                }
                
                
                
                /*
                HStack {
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            scrum.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
                */
            }
            Section(header: Text("Disabled contacts")) {
                ForEach($contacts) { $contact in
                    if !contact.enabledForQuiz {
                        Text(contact.name)
                    }
                }
            }
            
            
        }
    }
}

struct QuizEditSheet_Previews: PreviewProvider {
    static var time: Double = 20.0
    static var previews: some View {
        QuizEditSheet(contacts: .constant(Contact.sampleData), time: .constant(time))

    }
}
