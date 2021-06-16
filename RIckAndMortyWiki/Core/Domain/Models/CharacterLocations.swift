//
//  CharacterLocations.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 16.06.21.
//

import Foundation

// MARK: - CharacterLocations
struct CharacterLocations: Codable {
    let info: CharacterLocationInfo
    let results: [CharacterLocation]
}

// MARK: - Info
struct CharacterLocationInfo: Codable {
    let count, pages: Int
    let next: String
    let prev: JSONNull?
}

// MARK: - Result
struct CharacterLocation: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}
