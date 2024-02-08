/*
See LICENSE folder for this sample’s licensing information.
 */

import Foundation

@MainActor
class ContactStore: ObservableObject {
    @Published var contacts: [Contact] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: false)
        .appendingPathComponent("Digits.data")
    }
    
    func load() async throws {
        let task = Task<[Contact], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let contactData = try JSONDecoder().decode([Contact].self, from: data)
            return contactData
        }
        let contacts = try await task.value
        self.contacts = contacts
    }
    
    func save(contacts: [Contact]) async throws {
            let task = Task {
                let data = try JSONEncoder().encode(contacts)
                let outfile = try Self.fileURL()
                try data.write(to: outfile)
            }
            _ = try await task.value
        }
}
