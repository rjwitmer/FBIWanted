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
    @State var persons: Persons = Persons()
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
                    
                }
                .listStyle(.automatic)
                .navigationTitle(Text("FBI Wanted by Title"))
                .toolbar {
                    ToolbarItem(placement: .status) {
                        Text("Titles: \(searchResults.count) of \(persons.personsArray.count)")
                    }
                }
                .searchable(text: $searchText)
                
                if persons.isLoading {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(4.0)
                }
            }
        }
        .padding()
        .task {
            await persons.getData()
        }
    }
    
    var searchResults: [Person] {
        if searchText.isEmpty {
            return persons.personsArray
        } else {    // There is searchText data
            return persons.personsArray.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    LaunchView()
}
