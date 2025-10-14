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
    var aliases: [String]?   // Array of aliases, if entered
    var images: [PersonImage]?  // Array of String URL of the person images, if entered
    var dates_of_birth_used: [String]?  // Array of birth dates, if entered
    var place_of_birth: String?  // Birth Place, if entered
    var hair: String?  // Hair colour, if entered
    var eyes: String?  // Eye colour, if entered
    var height_min: Int?  // Minimum height, if entered - doesn't load
    var height_max: Int?  // Maximum height, if entered - doesn't load
    var weight: String?  // Weight, if entered
    var sex: String?  // Sex, if entered
    var race:String?  // Race, if entered
    var reward_text: String?  // Reward, if entered
    var remarks: String?  // Remarks, if entered
    var details: String?  // Details, if entered
    var caution: String?  // Caution, if entered
    var warning_message: String?  // Warning Message, if entered
    var nationality: String?  // Nationality, if entered
    
    enum CodingKeys: CodingKey {    // Ignore the id when decoding
        case title
        case description
        case subjects
        case aliases
        case images
        case dates_of_birth_used
        case place_of_birth
        case hair
        case eyes
        case height_min
        case height_max
        case weight
        case sex
        case race
        case reward_text
        case remarks
        case details
        case caution
        case warning_message
        case nationality
    }
}

struct PersonImage: Codable {
    var large: String?
}

