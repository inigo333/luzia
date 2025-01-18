//
//  PlanetView.swift
//  luzia
//
//  Created by Inigo Mato on 18/01/2025.
//

import SwiftUI

struct PlanetView: View {
    var planet: Planet
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(planet.name)
                    .font(.system(size: 34, weight: .bold))
                    .padding(.top, 20)
                
                VStack(spacing: 16) {
                    planetInfoRow(title: "Climate", value: planet.climate)
                    planetInfoRow(title: "Population", value: planet.population.prettyPrinted())
                    planetInfoRow(title: "Diameter", value: planet.diameter.prettyPrinted())
                    planetInfoRow(title: "Gravity", value: planet.gravity)
                    planetInfoRow(title: "Terrain", value: planet.terrain)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemBackground))
                        .shadow(radius: 5)
                )
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func planetInfoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.body)
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    PlanetView(planet: Planet.Mocks.first!)
}
