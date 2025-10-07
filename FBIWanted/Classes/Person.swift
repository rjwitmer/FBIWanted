//
//  Person.swift
//  FBIWanted
//
//  Created by Bob Witmer on 2025-09-02.
//

import Foundation
import SwiftData

struct Person: Codable, Identifiable {
    let id: String = UUID().uuidString  // Assign unique ID for each Person
    var title: String = ""      // FBI Full Name in Caps
    var description: String = ""       // Details
    var subjects:[String] = []  // Subjects array
    var aliases: [String]?   // Array of aliases, could be null
    var images: [PersonImage]?  // Array of String URL of the person images
    var dates_of_birth_used: [String]?  // Array of birth dates
    
    enum CodingKeys: CodingKey {    // Ignore the id when decoding
        case title
        case description
        case subjects
        case aliases
        case images
        case dates_of_birth_used
    }
}

struct PersonImage: Codable {
    var large: String?
}

