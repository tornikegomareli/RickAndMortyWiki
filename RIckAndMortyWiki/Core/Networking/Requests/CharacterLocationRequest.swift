//
//  LocationRequest.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 16.06.21.
//

import Foundation
import Alamofire

struct LocationRequest: Requestable {
  var endpoint: String = "/location"
  
  typealias Element = CharacterLocations

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

