//
//  PlanetRowView.swift
//  luzia
//
//  Created by Inigo Mato on 18/01/2025.
//

import SwiftUI

struct PlanetRowView: View {
    var planet: Planet
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name: \(planet.name)")
                .font(.headline)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Climate: \(planet.climate)")
                .font(.subheadline)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("Population: \(planet.population.prettyPrinted())")
                .font(.subheadline)
        }
    }
}

#Preview {
    List(Planet.Mocks) { planet in
        PlanetRowView(planet: planet)
    }
}
