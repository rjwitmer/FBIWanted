//
//  FBIWantedAPI.swift
//  FBIWanted
//
//  Created by Bob Witmer on 2025-10-05.
//

import Foundation

struct FBIWantedAPI: Codable {  // First Level RestAPI structure
    var total: Int
    var items: [Person]
    var page: Int
}
