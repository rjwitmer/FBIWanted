//
//  Persons.swift
//  FBIWanted
//
//  Created by Bob Witmer on 2025-09-02.
//

import Foundation

@Observable
class Persons: Codable {
    private struct Returned: Codable {
        var total: Int
        var items: [Person]
    }
    
    var urlString: String = "https://api.fbi.gov/wanted/v1/list"
    var total: Int = 0
    var personsArray: [Person] = []
    var isLoading: Bool = false
    
    func getData() async {
        print("🕸️ We are accessing url: \(urlString)")
        isLoading = true
        // Create a URL
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from: \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)      // '_' could be replaced with 'response' but is not used in this app
            
            // Try to decode the JSON data into our own data structures
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("😡 JSON ERROR: Could not decode JSON data")
                isLoading = false
                return
            }
            Task { @MainActor in
                self.total = returned.total
                self.personsArray = self.personsArray + returned.items
                
                
                isLoading = false
            }
            
            
            
        } catch {
            print("😡 ERROR: Could not get data from: \(urlString)")
            isLoading = false
        }
    }
}
