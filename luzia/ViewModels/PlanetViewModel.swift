//
//  PlanetViewModel.swift
//  luzia
//
//  Created by Inigo Mato on 22/01/2025.
//

import SwiftUI

@MainActor
class PlanetViewModel: ObservableObject {
    var planet: Planet
    @Published var residents: [PeopleResponse] = []
    private let service = SWApiService()
    
    init(planet: Planet) {
        self.planet = planet
    }
    
    func requestResidents() async throws {
        var residents = [PeopleResponse]()
        for url in planet.residentsUrlStrings {
            let resident = try await service.requestResident(residentUrlString: url)
            residents.append(resident)
        }
        
        self.residents = residents
    }
}
