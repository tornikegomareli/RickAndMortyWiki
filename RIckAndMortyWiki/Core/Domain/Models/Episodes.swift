//
//  Episodes.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 16.06.21.
//

import Foundation

public struct Episodes: Codable {
    let info: EpisodeInfo
    let results: [Episode]
}

// MARK: - Info
struct EpisodeInfo: Codable {
    let count, pages: Int
    let next: String
    let prev: JSONNull?
}

// MARK: - Result
public struct Episode: Codable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
