//
//  Character.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 16.06.21.
//

import Foundation

// MARK: - CharacterInfo
struct Characters: Codable {
  let info: CharacterInfo
  let results: [Character]
}

// MARK: - Info
struct CharacterInfo: Codable {
  let count, pages: Int
  let next: String
  let prev: JSONNull?
}

// MARK: - Result
struct Character: Codable {
  let id: Int
  let name: String
  let status: Status
  let species: Species
  let type: String
  let gender: Gender
  let origin, location: Location
  let image: String
  let episode: [String]
  let url: String
  let created: String
}

enum Gender: String, Codable {
  case female = "Female"
  case male = "Male"
  case unknown = "unknown"
}

struct Location: Codable {
  let name: String
  let url: String
}

enum Species: String, Codable {
  case alien = "Alien"
  case human = "Human"
}

enum Status: String, Codable {
  case alive = "Alive"
  case dead = "Dead"
  case unknown = "unknown"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
      return true
    }

    public var hashValue: Int {
      return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      if !container.decodeNil() {
        throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
      }
    }

    public func encode(to encoder: Encoder) throws {
      var container = encoder.singleValueContainer()
      try container.encodeNil()
    }
}

