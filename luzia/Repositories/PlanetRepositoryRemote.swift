//
//  PlanetRepositoryRemote.swift
//  luzia
//
//  Created by Inigo Mato on 17/01/2025.
//

import Foundation

final class PlanetRepositoryRemote: PlanetRepository {
    private let swApiService = SWApiService()
    
    func requestItems(page: UInt) async throws -> [Planet] {
        try await swApiService.requestItems(page: page)
    }
}
