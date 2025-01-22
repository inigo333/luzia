//
//  SWApiService.swift
//  luzia
//
//  Created by Inigo Mato on 17/01/2025.
//

import Foundation

/// https://swapi.dev/api/

final class SWApiService {
    func requestItems<T: SWApiAttributable>(pageUrlString: String) async throws -> [T] {
        guard let pageUrl = URL(string: pageUrlString) else {
            let error = URLError(.badURL)
            print(error.localizedDescription)
            throw error
        }
        
        let (data, response) = try await URLSession.shared.data(from: pageUrl)

        guard let httpResponse = response as? HTTPURLResponse else {
            let error = URLError(.badServerResponse)
            print(error.localizedDescription)
            throw error
        }
        
        // if let jsonString = String(data: data, encoding: .utf8) {
        //     print(jsonString)
        // }
        
        switch httpResponse.statusCode {
        case 200:
            let response = try JSONDecoder().decode(T.swApiAttribute.responseType, from: data)
            let nextPageUrlString = response.next
            let items = response.results.compactMap {
                T.swApiAttribute.convert($0, pageUrlString: pageUrlString, nextPageUrlString: nextPageUrlString) as T?
            }
            return items
        case 400:
            throw URLError(.badServerResponse)
        case 401:
            throw URLError(.userAuthenticationRequired)
        case 403:
            throw URLError(.noPermissionsToReadFile)
        case 404:
            throw URLError(.fileDoesNotExist)
        case 500...599:
            throw URLError(.badServerResponse)
        default:
            throw URLError(.unknown)
        }
    }
    
    func requestResident(residentUrlString: String) async throws -> PeopleResponse {
        guard let pageUrl = URL(string: residentUrlString) else {
            let error = URLError(.badURL)
            print(error.localizedDescription)
            throw error
        }
        
        let (data, response) = try await URLSession.shared.data(from: pageUrl)
        
        // if let jsonString = String(data: data, encoding: .utf8) {
        //     print(jsonString)
        // }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            let error = URLError(.badServerResponse)
            print(error.localizedDescription)
            throw error
        }
        
        switch httpResponse.statusCode {
        case 200:
            let resident = try JSONDecoder().decode(PeopleResponse.self, from: data)
            return resident
        default:
            throw URLError(.unknown)
        }
    }
}
