//
//  DigitsApp.swift
//  Digits
//
//  Created by Michael McKinley on 1/16/24.
//

import SwiftUI

@main
struct DigitsApp: App {
    @State var contacts: [Contact] = Contact.sampleData
    var body: some Scene {
        WindowGroup {
            HomeView(contacts: $contacts)
        }
    }
}
