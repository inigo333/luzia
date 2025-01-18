//
//  PlanetRepositoryPersisted.swift
//  luzia
//
//  Created by Inigo Mato on 17/01/2025.
//

import SwiftData
import SwiftUI

private let pageSize: UInt = 10

@MainActor
final class PlanetRepositoryPersisted: PlanetRepository {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func requestItems(page: UInt) async throws -> [Planet] {
        let items = try requestAllItems()
        let start = Int(page * pageSize)
        guard items.count > start else { return [] }
        
        let end = min(start + Int(pageSize), items.count)
        return Array(items[start..<end])
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
    
    private func requestAllItems() throws -> [Planet] {
        let fetchDescriptor = FetchDescriptor<Planet>(sortBy: [SortDescriptor(\.url, order: .forward)])
        let items = try modelContext.fetch(fetchDescriptor)
        return items
    }
}
