//
//  CharactersRequest.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 16.06.21.
//

import Foundation
import Alamofire

struct CharacterRequest: Requestable {
  typealias Element = Characters

  var param: Parameters?

  var httpMethod: HTTPMethod {
    return .get
  }

  var endpoint: String {
    return "/character"
  }

  var parameterEncoding: ParameterEncoding {
    return JSONEncoding.default
  }

  // Init
  init(param: Parameters? = [:]) {
    self.param = param
  }
}

