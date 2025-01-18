//
//  Planet.swift
//  luzia
//
//  Created by Inigo Mato on 17/01/2025.
//

import Foundation
import SwiftData

@Model
final class Planet: SWApiAttributable {
    static var swApiAttribute = SWApiAttribute.planets
    
    var name: String
    var climate: String
    var population: String
    var diameter: String
    var gravity: String
    var terrain: String
    var url: String
    
    init(name: String,
         climate: String,
         population: String,
         diameter: String,
         gravity: String,
         terrain: String,
         url: String) {
        self.name = name
        self.climate = climate
        self.population = population
        self.diameter = diameter
        self.gravity = gravity
        self.terrain = terrain
        self.url = url
    }
    
    convenience init(from planetResponse: PlanetsResponse.Planet) {
        self.init(name: planetResponse.name,
                  climate: planetResponse.climate,
                  population: planetResponse.population,
                  diameter: planetResponse.diameter,
                  gravity: planetResponse.gravity,
                  terrain: planetResponse.terrain,
                  url: planetResponse.url)
    }
}

extension Planet: CustomStringConvertible {
    var description: String { name }
}

extension Planet {
    static var Mocks: [Planet] {
        [
            Planet(name: "Tatooine",
                   climate: "arid",
                   population: "200000",
                   diameter: "10465",
                   gravity: "1 standard",
                   terrain: "desert",
                   url: "https://swapi.dev/api/planets/1/"),
            Planet(name: "Alderaan",
                   climate: "temperate",
                   population: "2000000000",
                   diameter: "12500",
                   gravity: "1 standard",
                   terrain: "grasslands, mountains",
                   url: "https://swapi.dev/api/planets/2/"),
            Planet(name: "Yavin IV",
                   climate: "temperate, tropical",
                   population: "1000",
                   diameter: "10200",
                   gravity: "1 standard",
                   terrain: "jungle, rainforests",
                   url: "https://swapi.dev/api/planets/3/"),
            Planet(name: "Hoth",
                   climate: "frozen",
                   population: "unknown",
                   diameter: "7200",
                   gravity: "1.1 standard",
                   terrain: "tundra, ice caves, mountain ranges",
                   url: "https://swapi.dev/api/planets/4/")
        ]
    }
}
