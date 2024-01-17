//
//  DigitsApp.swift
//  Digits
//
//  Created by Michael McKinley on 1/16/24.
//

import SwiftUI

@main
struct DigitsApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(contacts: Contact.sampleData)
        }
    }
}
