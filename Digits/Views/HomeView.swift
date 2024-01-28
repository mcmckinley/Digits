import SwiftUI

struct HomeView: View {
    
    @Binding var contacts: [Contact]
    
    @State private var isPresentingSettingsView = false
    
    @State var isInQuizView = false

    var body: some View {
        NavigationStack {
            
            if (contacts.filter{$0.enabled}).count > 0 {
                List($contacts) { $contact in
                    if contact.enabled {
                        HStack {
                            Button(action: {
                                print("hello from \(contact.name)")
                            }) {
                                Image(systemName: "plus.circle.fill")
                            }
                            NavigationLink(destination: ContactDetailSheet(contact: $contact)){
                                ContactCard(contact: $contact)
                            }
                            
                        }
                        
                    }
                }
                .navigationTitle("Digits Quiz")
            } else {
                List {
                    Text("No contacts currently selected. ")
                }
                .navigationTitle("Digits Quiz")
            }
            
            HStack {
                Spacer()
                Button(action: {
                    isPresentingSettingsView = true
                }) {
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
        }
        .sheet(isPresented: $isPresentingSettingsView) {
            EditQuizSheet(contacts: $contacts)
        }
    }
}

#Preview {
    HomeView(contacts: .constant(Contact.sampleData))
}
