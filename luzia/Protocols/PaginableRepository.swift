//
//  PaginableRepository.swift
//  luzia
//
//  Created by Inigo Mato on 17/01/2025.
//

protocol PaginableRepository {
    associatedtype Item: Equatable
    func requestItems(page: UInt) async throws -> [Item]
    func saveItems(_ items: [Item]) async throws
    func deleteItems(_ items: [Item]?) async throws
}

extension PaginableRepository {
    func saveItems(_ items: [Item]) async throws {}
    func deleteItems(_ items: [Item]?) async throws {}
}
