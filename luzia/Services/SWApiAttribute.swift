//
//  SWApiAttribute.swift
//  luzia
//
//  Created by Inigo Mato on 18/01/2025.
//

enum SWApiAttribute: String {
    case planets
}

extension SWApiAttribute {
    var endpoint: String { rawValue }
    
    var responseType: any SWApiResponse.Type {
        switch self {
        case .planets: return PlanetsResponse.self
        }
    }
    
    func convert<T>(_ item: Any) -> T? {
        switch self {
        case .planets:
            guard let result = item as? PlanetsResponse.Planet else { return nil }
            return Planet(from: result) as? T
        }
    }
}

