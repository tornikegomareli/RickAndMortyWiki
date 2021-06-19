//
//  CharactersRequest.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 16.06.21.
//

import Foundation
import Alamofire

struct CharacterRequest: Requestable {
  var endpoint: String =  "character"
  
  typealias Element = MultipleCharacters

  var param: Parameters?

  var httpMethod: HTTPMethod {
    return .get
  }

  var parameterEncoding: ParameterEncoding {
    return URLEncoding.default
  }

  // Init
  init(param: Parameters? = [:]) {
    self.param = param
  }
}

