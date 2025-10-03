//
//  LaunchView.swift
//  FBIWanted
//
//  Created by Bob Witmer on 2025-09-01.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct LaunchView: View {
    @State var personsVM: PersonsVM = PersonsVM()
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(searchResults) { person in
                    VStack {
                        
                        NavigationLink {
                            DetailView(person: person)
                        } label: {
                            Text(person.title.capitalized)
                                .font(.title2)
                        }
                        
                        Spacer()
                    }
//                    .task {
//                        if personsVM.page < personsVM.total/20 {   // API uses 20 persons per page
//                            personsVM.page += 1
//                            await personsVM.getNextPage()
//                        } else {
//                            return
//                        }
//                    }
                }
                .listStyle(.automatic)
                .navigationTitle(Text("FBI Title"))
                .toolbar {
                    ToolbarItem(placement: .status) {
                        Text("Titles: \(searchResults.count) of \(personsVM.total)")
                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button("Load All") {
                            Task {
                                await personsVM.loadAll()
                            }
                        }

                    }
                    ToolbarItem(placement: .bottomBar) {
                        Button("Next Page") {
                            Task {
                                await personsVM.getNextPage()
                            }
                        }
                    }
                }
                .searchable(text: $searchText)
                
                if personsVM.isLoading {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(4.0)
                }
            }
        }
        .padding()
        .task {
            await personsVM.getData()
        }
    }
    
    var searchResults: [Person] {
        if searchText.isEmpty {
            return personsVM.personsArray
        } else {    // There is searchText data
            return personsVM.personsArray.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    LaunchView()
}
