//
//  SWApiAttribute.swift
//  luzia
//
//  Created by Inigo Mato on 18/01/2025.
//

import Foundation

enum SWApiAttribute: String {
    case planets
}

extension SWApiAttribute {
    var endpoint: String { rawValue }
    
    var endpointUrl: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "swapi.dev"
        components.path = "/api/\(endpoint)/"
        
        return components.url
    }
    
    var responseType: any SWApiResponse.Type {
        switch self {
        case .planets: return PlanetsResponse.self
        }
    }
    
    func convert<T>(_ item: Any, pageUrlString: String, nextPageUrlString: String?) -> T? {
        switch self {
        case .planets:
            guard let result = item as? PlanetsResponse.Planet else { return nil }
            return Planet(from: result, pageUrlString: pageUrlString, nextPageUrlString: nextPageUrlString) as? T
        }
    }
}
