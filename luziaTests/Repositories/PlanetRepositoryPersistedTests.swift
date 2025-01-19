//
//  PlanetRepositoryPersistedTests.swift
//  luzia
//
//  Created by Inigo Mato on 19/01/2025.
//

import SwiftData
import XCTest
@testable import luzia

@MainActor
final class PlanetRepositoryPersistedTests: XCTestCase {
    var planetRepository: PlanetRepositoryPersisted!
    var modelContext: ModelContext!

    override func setUp() {
        super.setUp()
        
        do {
            let schema = Schema([Planet.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
            let modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            modelContext = ModelContext(modelContainer)
            planetRepository = PlanetRepositoryPersisted(modelContext: modelContext)
        } catch {
            XCTFail("Failed to initialize in-memory ModelContainer: \(error)")
        }
    }

    override func tearDown() {
        planetRepository = nil
        modelContext = nil
        
        super.tearDown()
    }
    
    func testSaveItems() async throws {
        // Given some planets that are saved, belonging to page=1 and 2
        let planetsToSave = Planet.Mocks
        try await planetRepository.saveItems(planetsToSave)
        
        // Then we should be able to retrieve them
        let retrievedPlanetsPage1 = try await planetRepository.requestItems(pageUrlString: "https://swapi.dev/api/planets?page=1")
        let retrievedPlanetsPage2 = try await planetRepository.requestItems(pageUrlString: "https://swapi.dev/api/planets?page=2")
        let retrievedPlanets = retrievedPlanetsPage1 + retrievedPlanetsPage2
        
        XCTAssertEqual(retrievedPlanetsPage1.count, 3, "Retrieved planet count in page 1 should match the saved count in page 1")
        XCTAssertEqual(retrievedPlanetsPage2.count, 1, "Retrieved planet count in page 2 should match the saved count in page 2")
        XCTAssertEqual(retrievedPlanets.count, planetsToSave.count, "Retrieved planet count should match the saved count")
        XCTAssertEqual(retrievedPlanets, planetsToSave, "The retrieved planets should match the ones saved")
    }

    func testDeleteSpecificItems() async throws {
        // Given some planets that are saved
        let planets = Planet.Mocks
        try await planetRepository.saveItems(planets)
        
        // When we delete them
        try await planetRepository.deleteItems(planets)
        
        // Then retrieving some items should return an empty list
        let retrievedPlanets = try await planetRepository.requestItems(pageUrlString: "https://swapi.dev/api/planets?page=1")
        XCTAssertTrue(retrievedPlanets.isEmpty, "All planets should be deleted")
    }
    
    func testDeleteAllItems() async throws {
        // Given some planets that are saved
        let planets = Planet.Mocks
        try await planetRepository.saveItems(planets)
        
        // When we delete them
        try await planetRepository.deleteItems()
        
        // Then retrieving all items should return an empty list
        let retrievedPlanetsPage1 = try await planetRepository.requestItems(pageUrlString: "https://swapi.dev/api/planets?page=1")
        let retrievedPlanetsPage2 = try await planetRepository.requestItems(pageUrlString: "https://swapi.dev/api/planets?page=2")
        XCTAssertTrue(retrievedPlanetsPage1.isEmpty, "All planets should be deleted")
        XCTAssertTrue(retrievedPlanetsPage2.isEmpty, "All planets should be deleted")
    }
}
