import SwiftUI

struct HomeView: View {
    
    @Binding var contacts: [Contact]
    
    @State private var isPresentingSettingsView = false
    
    @State var isInQuizView = false
    
    @Environment(\.colorScheme) var colorScheme
    var lightGrey = Color(red: 0.9, green: 0.9, blue: 0.9)
    var darkGrey = Color(red: 0.3, green: 0.3, blue: 0.3)
    var disabledColor: Color {
        colorScheme == .light ? lightGrey : darkGrey
    }

    var body: some View {
        NavigationStack {
            
            if contacts.count > 0 {
                // Sort contacts by enabled first and disabled last, then filter out those that are ignored
                List($contacts.sorted(by: {$0.enabled.wrappedValue && !$1.enabled.wrappedValue}).filter{$0.allowed.wrappedValue}) { $contact in
                    ContactCard(contact: $contact)
                        //.listRowBackground(contact.enabled ? disabledColor : Color.clear)
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
