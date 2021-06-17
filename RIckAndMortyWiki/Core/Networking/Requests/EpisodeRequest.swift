//
//  EpisodeRequest.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 16.06.21.
//

import Foundation
import Alamofire

struct EpisodeRequest: Requestable {
  typealias Element = Episodes

  var param: Parameters?

  var httpMethod: HTTPMethod {
    return .get
  }

  var endpoint: String {
    return "episode"
  }

  var parameterEncoding: ParameterEncoding {
    return URLEncoding.default
  }

  // Init
  init(param: Parameters? = [:]) {
    self.param = param
  }
}

