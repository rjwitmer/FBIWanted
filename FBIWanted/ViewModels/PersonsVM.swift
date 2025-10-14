//
//  Persons.swift
//  FBIWanted
//
//  Created by Bob Witmer on 2025-09-02.
//

import Foundation

@MainActor
class PersonsVM: ObservableObject {
    
    @Published var personsArray: [Person] = []
    @Published var total: Int = 0
    @Published var errorMessage: String?
    
    private let networkService: NetworkService = NetworkService()
    var isLoading: Bool = false
    var moreData: Bool = true
    
    func getData() async {
        
        isLoading = true
        Task {
            do {
                let decodedData = try await networkService.fetchData()
                DispatchQueue.main.async {
                    if decodedData.items.isEmpty {
                        self.moreData = false
                        print("No more data")
                    } else {
                        self.personsArray.append(contentsOf: decodedData.items)
                        self.total = decodedData.total
    //                    print("Total: \(self.total)")
    //                    print("Total in Array: \(self.personsArray.count)")
                        self.isLoading = false
                    }

                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "😡 ERROR: Problem fetching data: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func getNextPage() async {
            Task {
                self.isLoading = true
                try await Task.sleep(nanoseconds: 500_000_000)  // Add a 0.5 second delay on recursive calls
                await self.getData()
            }
    }
    
    func loadAll() async {
        Task {
            self.isLoading = true
            try await Task.sleep(nanoseconds: 500_000_000)  // Add a 0.5 second delay on recursive calls
            if self.moreData {  // Check if the last call returned data and end recursive calls if no more data
                await getData() // Get Next Page of data
                await loadAll() // Recursive call until nextPageURL is null
            }
        }
    }

    
}
