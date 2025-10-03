//
//  Persons.swift
//  FBIWanted
//
//  Created by Bob Witmer on 2025-09-02.
//

import Foundation

@Observable
class PersonsVM: Codable {
    private struct Returned: Codable {
        var total: Int
        var items: [Person]
        var page: Int
    }
    

    var urlString: String = "https://api.fbi.gov/wanted/v1/list"
    var total: Int = 0
    var personsArray: [Person] = []
    var page: Int = 1
    var pageParm: String = ""
    var isLoading: Bool = false
    
    func getData() async {
        pageParm = "?page=\(page)"
        
        print("🕸️ We are accessing url: \(urlString + pageParm)")
        isLoading = true
        // Create a URL
        guard let url = URL(string: urlString + pageParm) else {
            print("😡 ERROR: Could not create a URL from: \(urlString + pageParm)")
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
                self.page = returned.page
                print("Total: \(self.total)")
                
                isLoading = false
            }
            
            
            
        } catch {
            print("😡 ERROR: Could not get data from: \(urlString)")
            isLoading = false
        }
    }
    
    func getNextPage() async {
        if page < total / 20 {
            page += 1
            await getData()
        }
    }
    
    func loadAll() async {
        Task { @MainActor in
            if page < total / 20 {
                page += 1
                await getData() // Get Next Page of data
                await loadAll() // Recursive call until nextPageURL is null
            } else {
                return
            }
        }
    }
}
