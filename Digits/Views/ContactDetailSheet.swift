import SwiftUI

struct ContactDetailSheet: View {
    @Binding var contact: Contact
    @State private var editingContact: Contact = Contact.emptyContact
    @State var isDisplayingEditContactSheet: Bool = false

    
    var body: some View {
        List {
            Section(header: Text("digits")){
                Text(contact.number)
            }
        }
        .navigationTitle(contact.name)
        .toolbar {
            Button("Edit") {
                isDisplayingEditContactSheet = true
                editingContact = contact
            }
        }
        .sheet(isPresented: $isDisplayingEditContactSheet) {
            NavigationStack {
                EditContactSheet(contact: $editingContact)
                    .navigationTitle(contact.name)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isDisplayingEditContactSheet = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isDisplayingEditContactSheet = false
                                contact = editingContact
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    ContactDetailSheet(contact: .constant(Contact.sampleData[0]))
}
