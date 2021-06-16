//
//  RestClient.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 16.06.21.
//

import Alamofire
import RxSwift

class RestClient {
  internal let manager: Session

  init () {
    manager = Session.default
  }

  public func fetch<Request: Requestable>(request: Request.Type, withParams params: Parameters? = [:]) -> Observable<Request.Element> {
    let req = request.init(manager: manager, param: params)
    return req.toObservable()
  }
}
