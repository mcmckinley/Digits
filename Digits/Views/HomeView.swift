import SwiftUI

struct HomeView: View {
    
    @Binding var contacts: [Contact]
    
    @State private var isPresentingSettingsView = false
    @State private var timePerQuestion: Double = 8.0
    @State var isInQuizView = false

    var body: some View {
        NavigationStack {
            List($contacts) { $contact in
                if contact.enabled {
                    ContactCard(contact: $contact)
                }
            }
            .navigationTitle("Digits Quiz")
            
            HStack {
                Button(action: {
                    isPresentingSettingsView = true
                }) {
                    Text("Settings")
                        .bold()
                        .foregroundColor(.white)
                        .padding([.top, .bottom], 16)
                        .padding([.leading, .trailing], 61)
                        .background(Color.gray)
                        .cornerRadius(10)
                    
                }
                NavigationLink(destination: QuizView(contacts: contacts.filter{$0.enabled}) ) {
                    Text("Start")
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                        .padding([.leading, .trailing], 55)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
        .sheet(isPresented: $isPresentingSettingsView) {
            EditQuizSheet(contacts: $contacts, time: $timePerQuestion)
        }
    }
}

#Preview {
    HomeView(contacts: .constant(Contact.sampleData))
}
