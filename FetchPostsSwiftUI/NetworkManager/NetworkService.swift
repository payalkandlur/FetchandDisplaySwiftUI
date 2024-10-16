//
//  NetworkService.swift
//  FetchPostsSwiftUI
//
//  Created by Payal Kandlur on 10/16/24.
//

import Foundation

enum NetworkError: Error {
    case invalidData
    case invalidResponse
    case invalidURL
}

protocol ApiService {
    func fetch<T: Decodable>(_ type: T.Type) async throws -> T
}

class NetworkService: ApiService {
    private let endpointUrl = "https://dummyjson.com/users/"
    
    func fetch<T>(_ type: T.Type) async throws -> T where T : Decodable {
      
        guard let url = URL(string: endpointUrl) 
        else { throw NetworkError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
        else { throw NetworkError.invalidResponse }
        do {
            let jsonDecoder = JSONDecoder()
            let user = try jsonDecoder.decode(T.self, from: data)
            return user
        } catch {
            throw NetworkError.invalidData
        }
    }
}
