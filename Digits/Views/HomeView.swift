//
//  HomeView.swift
//  Digits
//
//  Created by Michael McKinley
//
//  Description:
//      - Acts as the home view for the app. Displays title, contacts, settings button and start button. User can toggle whether the contact will show up in the quiz by clicking on them.

import SwiftUI

struct HomeView: View {
    
    @Binding var contacts: [Contact]
    
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: ()->Void
    
    @State var isDisplayingAppInfoSheet = false

    var body: some View {
        NavigationStack {
            if (contacts.filter{$0.allowed}).count > 0 {
                // Sort contacts by enabled first and disabled last, then filter out those that are ignored
                List {
                    Section {
                        ForEach($contacts.filter{$0.enabled.wrappedValue && $0.allowed.wrappedValue}) { $contact in
                            ContactCard(contact: $contact)
                        }
                    }
                    Section (header: Text("Won't show in quiz")){
                        ForEach($contacts.filter{!$0.enabled.wrappedValue && $0.allowed.wrappedValue}) { $contact in
                            ContactCard(contact: $contact)
                        }
                    }
                }
                .navigationTitle("Digits Quiz")
            } else {
                // Error message if all contacts are ignored
                List {
                    Text("Go to settings to add contacts!")
                }
                .navigationTitle("Digits Quiz")
            }
            
            // Settings and Start button
            HStack {
                Spacer()
                NavigationLink(destination: SettingsView(contacts: $contacts)){
                    Text("Settings")
                        .bold()
                        .foregroundColor(.white)
                        .padding([.top, .bottom], 16)
                        .padding([.leading, .trailing], 40)
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                if (contacts.filter{$0.enabled}).count > 0{
                    NavigationLink(destination: QuizView(contacts: contacts.filter{$0.enabled}) ) {
                        Text("Start")
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .padding([.leading, .trailing], 40)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                Spacer()
            }
            // Info button
            .toolbar {
                Button(action: {
                    isDisplayingAppInfoSheet = true;
                }) {
                    Image(systemName: "info.circle")
                }
            }
        }
        .onChange(of: scenePhase) { _, phase in
            if phase == .inactive { saveAction() }
        }
        .sheet(isPresented: $isDisplayingAppInfoSheet){
            AppInfoSheet()
        }
    }
}

#Preview {
    HomeView(contacts: .constant(Contact.sampleData), saveAction: {})
}
