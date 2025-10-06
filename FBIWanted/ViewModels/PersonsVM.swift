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
                    self.errorMessage = "😡 ERROR: Problem fetching data: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func getNextPage() async {
            Task {
                await self.getData()
            }
    }
    
    func loadAll() async {
        Task {
            await getData() // Get Next Page of data
            if self.moreData {
                await loadAll() // Recursive call until nextPageURL is null
            }
        }
    }
}
