//
//  PlanetRepositoryPersisted.swift
//  luzia
//
//  Created by Inigo Mato on 17/01/2025.
//

import SwiftData
import SwiftUI

@MainActor
final class PlanetRepositoryPersisted: PlanetRepository {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func requestItems(pageUrlString: String) async throws -> [Planet] {
        let fetchDescriptor = FetchDescriptor<Planet>(predicate: #Predicate { $0.pageUrlString == pageUrlString },
                                                      sortBy: [SortDescriptor(\.urlString)])
        let items = try modelContext.fetch(fetchDescriptor)
        return items
    }
    
    func saveItems(_ items: [Planet]) async throws {
        for item in items {
            modelContext.insert(item)
        }
        
        try modelContext.save()
    }
    
    func deleteItems(_ items: [Planet]? = nil) async throws {
        if let items {
            for item in items {
                modelContext.delete(item)
            }
        } else {
            try modelContext.delete(model: Planet.self)
        }
    }
}
