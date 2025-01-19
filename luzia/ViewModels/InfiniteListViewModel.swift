//
//  InfiniteListViewModel.swift
//  luzia
//
//  Created by Inigo Mato on 18/01/2025.
//

import SwiftUI

@MainActor
final class InfiniteListViewModel<Repository: PaginableRepository>: ObservableObject {
    @Published var items: [Repository.Item] = []
    @Published var isLoading = false
    @Published var isRefreshing = false
    private let attribute: SWApiAttribute
    private let repository: Repository
    private let threshold: UInt
    
    init(attribute: SWApiAttribute, repository: Repository, threshold: UInt = 5) {
        self.attribute = attribute
        self.repository = repository
        self.threshold = threshold
    }
    
    func requestInitialSetOfItems() async {
        guard let firstPageUrl = attribute.endpointUrl else { return }
        
        await requestItems(pageUrlString: firstPageUrl.absoluteString)
    }
    
    func requestItems(pageUrlString: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let newItems = try await repository.requestItems(pageUrlString: pageUrlString)
            items.append(contentsOf: newItems)
        } catch {
            print("\(#function) | \(error)")
        }
    }
    
    /// Used for infinite scrolling. Only requests more items if pagination criteria is met.
    func requestMoreItemsIfNeeded(item: Repository.Item, nextPageUrlString: String?) async {
        guard !isLoading, let nextPageUrlString else { return }
        
        guard let index = items.firstIndex(of: item),
              thresholdMet(total: items.count, index: index, threshold: threshold) else {
            return
        }
            
        // Request next page
        await requestItems(pageUrlString: nextPageUrlString)
    }
    
    func deleteItems(_ items: [Repository.Item]? = nil) async throws {
        try await repository.deleteItems(items)
        if let items {
            self.items = self.items.filter { !items.contains($0) }
        } else {
            self.items = []
        }
    }
    
    func refreshItems() async throws {
        isRefreshing = true
        defer { isRefreshing = false }
        
        try await deleteItems()
        await requestInitialSetOfItems()
    }
    
    /// Determines whether the threshold (items from end) has been met for requesting more items.
    private func thresholdMet(total: Int, index: Int, threshold: UInt) -> Bool {
        (total - index) == threshold
    }
}
