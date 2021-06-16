//
//  RestClient.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 16.06.21.
//

import Alamofire
import RxSwift

class RestClient {
  init () {}

  public func fetch<Request: Requestable>(request: Request.Type, withParams params: Parameters? = [:]) -> Observable<Request.Element> {
    let req = request.init(param: params)
    return req.toObservable()
  }
}
