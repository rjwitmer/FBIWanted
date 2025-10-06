//
//  NetworkService.swift
//  FBIWanted
//
//  Created by Bob Witmer on 2025-10-04.
//

import Foundation
import Network

class NetworkService {
    private let monitor: NWPathMonitor = NWPathMonitor()
    private let queue: DispatchQueue = DispatchQueue(label: "NetworkMonitor")
    private var isConnected: Bool = true
    private var page: Int = 1
    
    init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
    
    func fetchData() async throws -> FBIWantedAPI {
        guard isConnected else {
            throw NetworkError.noInternetConnection
        }
        let pageParm: String = "?page=\(page)"
        let url = URL(string: "https://api.fbi.gov/wanted/v1/list" + pageParm)!
        print("URL: \(url)")

        
        let (data, response) = try await URLSession.shared.data(from: url )
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            print("😡 ERROR: \(NetworkError.apiError)")
            throw NetworkError.apiError
        }
//        print("HTTP Status: \(httpResponse.statusCode)")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        if page <= 54 {
            page += 1
        }
        return try decoder.decode(FBIWantedAPI.self, from: data)
    }
}

enum NetworkError: Error, LocalizedError {
    case noInternetConnection
    case apiError
    
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "No internet connection. Please check your network settings."
        case .apiError:
            return "An error occurred while fetching data from the FBI API. Please try again later."
        }
    }
}
