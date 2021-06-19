//
//  MultipleCharacters.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 19.06.21.
//

import Foundation

// MARK: - MultipleCharacter
public struct MultipleCharacter: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

typealias MultipleCharacters = [MultipleCharacter]
