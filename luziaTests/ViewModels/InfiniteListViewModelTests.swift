//
//  InfiniteListViewModelTests.swift
//  luzia
//
//  Created by Inigo Mato on 19/01/2025.
//

import XCTest
@testable import luzia

@MainActor
class InfiniteListViewModelTests: XCTestCase {
    var viewModel: InfiniteListViewModel<MockPaginableRepository>!
    var mockRepository: MockPaginableRepository!
    
    override func setUp() {
        super.setUp()
        
        mockRepository = MockPaginableRepository()
        viewModel = InfiniteListViewModel(attribute: .planets, repository: mockRepository, threshold: 1)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        
        super.tearDown()
    }
    
    func testRequestInitialSetOfItems() async {
        await viewModel.requestInitialSetOfItems()
        
        XCTAssertEqual(viewModel.items.count, 3)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testRequestItems() async {
        await viewModel.requestItems(pageUrlString: "https://example.com")
        
        XCTAssertEqual(viewModel.items.count, 3)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testRequestItemsWithError() async {
        mockRepository.shouldThrowError = true
        
        await viewModel.requestItems(pageUrlString: "https://example.com")
        
        XCTAssertTrue(viewModel.items.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testRequestMoreItemsIfNeeded() async {
        viewModel.items = ["Item1", "Item2", "Item3", "Item4", "Item5"]
        
        await viewModel.requestMoreItemsIfNeeded(item: "Item5", nextPageUrlString: "https://example.com/page2")
        
        XCTAssertEqual(viewModel.items.count, 8)
    }
    
    func testRequestMoreItemsIfNeededThresholdNotMet() async {
        viewModel.items = ["Item1", "Item2", "Item3", "Item4", "Item5", "Item6"]
        
        await viewModel.requestMoreItemsIfNeeded(item: "Item5", nextPageUrlString: "https://example.com/page2")
        
        XCTAssertEqual(viewModel.items.count, 6)
    }
    
    func testDeleteItems() async throws {
        viewModel.items = ["Item1", "Item2", "Item3"]
        
        try await viewModel.deleteItems(["Item2"])
        
        XCTAssertEqual(viewModel.items.count, 2)
        XCTAssertFalse(viewModel.items.contains("Item2"))
    }
    
    func testDeleteAllItems() async throws {
        viewModel.items = ["Item1", "Item2", "Item3"]
        
        try await viewModel.deleteItems()
        
        XCTAssertTrue(viewModel.items.isEmpty)
    }
    
    func testRefreshItems() async throws {
        viewModel.items = ["Item1", "Item2", "Item3"]
        
        try await viewModel.refreshItems()
        
        XCTAssertEqual(viewModel.items.count, 3)
        XCTAssertFalse(viewModel.isRefreshing)
    }
}

class MockPaginableRepository: PaginableRepository {
    typealias Item = String
    
    var items: [String] = []
    var shouldThrowError = false
    
    func requestItems(pageUrlString: String) async throws -> [String] {
        if shouldThrowError {
            throw NSError(domain: "MockError", code: 0, userInfo: nil)
        }
        return ["Item1", "Item2", "Item3"]
    }
    
    func saveItems(_ items: [String]) async throws {}
    
    func deleteItems(_ items: [String]?) async throws {
        if let items {
            self.items = self.items.filter { !items.contains($0) }
        } else {
            self.items = []
        }
    }
}
