//
//  MainView.swift
//  Digits
//
//  Created by Michael McKinley on 1/16/24.
//

import SwiftUI


struct MainView: View {
    @State var contacts: [Contact] = Contact.sampleData
    
    var body: some View {
        ContactView(contacts: $contacts)
    }
}

#Preview {
    MainView()
}
