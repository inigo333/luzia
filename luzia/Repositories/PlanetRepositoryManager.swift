//
//  PlanetRepositoryManager.swift
//  luzia
//
//  Created by Inigo Mato on 17/01/2025.
//

import Foundation

final class PlanetRepositoryManager: PlanetRepository {
    private let remoteRepository: any PlanetRepository
    private let localRepository: any PlanetRepository
    
    init(remoteRepository: any PlanetRepository, localRepository: any PlanetRepository) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
    
    func requestItems(pageUrlString: String) async throws -> [Planet] {
        // Try to fetch persisted items first
        let localItems = try await localRepository.requestItems(pageUrlString: pageUrlString)
        if !localItems.isEmpty {
            return localItems
        }

        // If no persisted data, fetch from remote and save locally
        let remoteItems = try await remoteRepository.requestItems(pageUrlString: pageUrlString)
        try await saveItems(remoteItems)
               
        return remoteItems
    }
    
    func saveItems(_ items: [Planet]) async throws {
        // Delegates save operation to local repository
        try await localRepository.saveItems(items)
    }
    
    func deleteItems(_ items: [Planet]? = nil) async throws {
        // Delegates delete operation to local repository
        try await localRepository.deleteItems(items)
    }
}
