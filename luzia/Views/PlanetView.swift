//
//  PlanetView.swift
//  luzia
//
//  Created by Inigo Mato on 18/01/2025.
//

import SwiftUI

struct PlanetView: View {
    var planet: Planet
    @StateObject var viewModel: PlanetViewModel
    
    init(planet: Planet) {
        self.planet = planet
        _viewModel = StateObject(wrappedValue: PlanetViewModel(planet: planet))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(planet.name)
                    .font(.system(size: 34, weight: .bold))
                    .padding(.top, 20)
                
                VStack(spacing: 16) {
                    InfoRow(title: "Climate", value: planet.climate)
                    InfoRow(title: "Population", value: planet.population.prettyPrinted())
                    InfoRow(title: "Diameter", value: planet.diameter.prettyPrinted())
                    InfoRow(title: "Gravity", value: planet.gravity)
                    InfoRow(title: "Terrain", value: planet.terrain)
                    InfoRow(title: "Residents", value: "")
                    LazyVStack(alignment: .leading) {
                        ForEach(viewModel.residents) { resident in
                            NavigationLink(value: resident) {
                                Text(resident.name)
                            }
                        }
                    }
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
        .navigationDestination(for: PeopleResponse.self) { resident in
            ResidentView(resident: resident)
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear() {
            Task {
                try await viewModel.requestResidents()
            }
        }
    }
}

#Preview {
    PlanetView(planet: Planet.Mocks.first!)
}
