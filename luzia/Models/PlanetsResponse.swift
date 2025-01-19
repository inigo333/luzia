//
//  PlanetsResponse.swift
//  luzia
//
//  Created by Inigo Mato on 17/01/2025.
//

import Foundation

struct PlanetsResponse: SWApiResponse {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PlanetsResponse.Planet]
    
    struct Planet: Decodable {
        let name: String
        let rotationPeriod: String
        let orbitalPeriod: String
        let diameter: String
        let climate: String
        let gravity: String
        let terrain: String
        let surfaceWater: String
        let population: String
        let residents: [String]
        let films: [String]
        let created: String
        let edited: String
        let urlString: String
        
        enum CodingKeys: String, CodingKey {
            case name
            case rotationPeriod = "rotation_period"
            case orbitalPeriod = "orbital_period"
            case diameter
            case climate
            case gravity
            case terrain
            case surfaceWater = "surface_water"
            case population
            case residents
            case films
            case created
            case edited
            case urlString = "url"
        }
    }
}

/*
 e.g.: https://swapi.dev/api/
 
 {
     "count": 60,
     "next": "https://swapi.dev/api/planets/?page=2",
     "previous": null,
     "results": [
         {
             "name": "Kamino",
             "rotation_period": "27",
             "orbital_period": "463",
             "diameter": "19720",
             "climate": "temperate",
             "gravity": "1 standard",
             "terrain": "ocean",
             "surface_water": "100",
             "population": "1000000000",
             "residents": [
                 "https://swapi.dev/api/people/22/",
                 "https://swapi.dev/api/people/72/",
                 "https://swapi.dev/api/people/73/"
             ],
             "films": [
                 "https://swapi.dev/api/films/5/"
             ],
             "created": "2014-12-10T12:45:06.577000Z",
             "edited": "2014-12-20T20:58:18.434000Z",
             "url": "https://swapi.dev/api/planets/10/"
         }
     ]
 }
 */
