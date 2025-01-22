//
//  PeopleResponse.swift
//  luzia
//
//  Created by Inigo Mato on 22/01/2025.
//

struct PeopleResponse: Decodable, Identifiable, Hashable {
    var id: String { name }
    
    var name: String
    var mass: String
    var height: String
}

extension PeopleResponse {
    static var Mock: PeopleResponse {
        PeopleResponse(name: "Luke", mass: "80", height: "1.80")
    }
}
