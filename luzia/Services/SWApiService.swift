//
//  SWApiService.swift
//  luzia
//
//  Created by Inigo Mato on 17/01/2025.
//

import Foundation

/// https://swapi.dev/api/

final class SWApiService {
    func requestItems<T: SWApiAttributable>(page: UInt) async throws -> [T] {
        guard let url = makeURL(attribute: T.swApiAttribute, page: page) else {
            let error = URLError(.badURL)
            print(error.localizedDescription)
            throw error
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            let error = URLError(.badServerResponse)
            print(error.localizedDescription)
            throw error
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print(jsonString)
        }
        
        switch httpResponse.statusCode {
        case 200:
            let response = try JSONDecoder().decode(T.swApiAttribute.responseType, from: data)
            let items = response.results.compactMap { T.swApiAttribute.convert($0) as T? }
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
    
    private func makeURL(attribute: SWApiAttribute, page: UInt, baseIndex: Int = 1) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "swapi.dev"
        components.path = "/api/\(attribute.endpoint)/"
        
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(Int(page)+baseIndex)"), // page number is 1 based index
        ]

        return components.url
    }
}
