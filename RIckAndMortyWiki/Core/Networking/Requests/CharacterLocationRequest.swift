//
//  LocationRequest.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 16.06.21.
//

import Foundation
import Alamofire

struct LocationRequest: Requestable {
  typealias Element = CharacterLocations

  var param: Parameters?

  var httpMethod: HTTPMethod {
    return .get
  }

  var endpoint: String {
    return "/location"
  }

  var parameterEncoding: ParameterEncoding {
    return JSONEncoding.default
  }

  // Init
  init(param: Parameters? = [:]) {
    self.param = param
  }
}

