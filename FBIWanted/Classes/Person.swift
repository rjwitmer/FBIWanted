//
//  Person.swift
//  FBIWanted
//
//  Created by Bob Witmer on 2025-09-02.
//

import Foundation

struct Person: Codable, Identifiable {
    let id: String = UUID().uuidString  // Assign unique ID for each Person
    var title: String = ""      // FBI Full Name in Caps
    
    enum CodingKeys: CodingKey {    // Ignore the id when decoding
        case title
    }
}
