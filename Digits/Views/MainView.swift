//
//  MainView.swift
//  Digits
//
//  Created by Michael McKinley on 1/16/24.
//

import SwiftUI


struct MainView: View {
    @Binding var contacts: [Contact]
    
    var body: some View {
        ContactView(contacts: $contacts)
    }
}

#Preview {
    MainView(contacts: .constant(Contact.sampleData))
}
