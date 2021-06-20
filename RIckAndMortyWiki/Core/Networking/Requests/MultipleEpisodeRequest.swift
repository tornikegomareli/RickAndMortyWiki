//
//  MultipleEpisodeRequest.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 20.06.21.
//

import Foundation
import Alamofire

struct MultipleEpisodeRequest: Requestable {
  typealias Element = MultipleEpisodes

  var endpoint:String = "episode"
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
