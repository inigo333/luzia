//
//  SWApiResponse.swift
//  luzia
//
//  Created by Inigo Mato on 18/01/2025.
//

protocol SWApiResponse<ResultsType>: Decodable {
    associatedtype ResultsType: Decodable
    
    var count: Int { get }
    var next: String? { get }
    var previous: String? { get }
    var results: [ResultsType] { get }
}
