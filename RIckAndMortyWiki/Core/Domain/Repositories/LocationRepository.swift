//
//  LocationRepository.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 17.06.21.
//

import Foundation
import RxSwift
import Resolver

protocol LocationRepositoring {
  func getLocations() -> Observable<LocationRequest.Element>
}

class LocationRepository: LocationRepositoring {
  @Injected private var restClient: RestClient
  func getLocations() -> Observable<LocationRequest.Element> {
    return restClient.fetch(request: LocationRequest.self)
  }
}

