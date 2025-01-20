//
//  PaginableRepository.swift
//  luzia
//
//  Created by Inigo Mato on 17/01/2025.
//

import Foundation

protocol PaginableRepository {
    associatedtype Item: Equatable
    func requestItems(pageUrlString: String) async throws -> [Item]
    func saveItems(_ items: [Item]) async throws
    func deleteItems(_ items: [Item]?) async throws
}

extension PaginableRepository {
    func saveItems(_ items: [Item]) async throws {}
    func deleteItems(_ items: [Item]?) async throws {}
}
