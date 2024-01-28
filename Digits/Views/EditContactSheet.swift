
import SwiftUI


struct EditContactSheet: View {
    @Binding var contact: Contact
    
    var body: some View {
        Form {
            Section(header: Text("Contact name")){
                TextField("Contact name", text: $contact.name)
            }
            Section(header: Text("Contact's digits")){
                TextField("Phone number", text: $contact.number)
                    .bold()
                HStack {
                    Text("Formatted: ")
                    Spacer()
                    Text(contact.numberFull)
                }
            }
            
        }
        
    }
}

struct EditContactSheet_Previews: PreviewProvider {

    static var previews: some View {
        EditContactSheet(contact: .constant(Contact.sampleData[0]))
    }
}
