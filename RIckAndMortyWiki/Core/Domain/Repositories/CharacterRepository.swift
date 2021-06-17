//
//  CharacterRepository.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 17.06.21.
//

import Foundation
import RxSwift
import Resolver

protocol CharacterRepositoring {
  func getCharacters() -> Observable<CharacterRequest.Element>
}

class CharacterRepository: CharacterRepositoring {
  @Injected private var restClient: RestClient
  func getCharacters() -> Observable<CharacterRequest.Element> {
    return restClient.fetch(request: CharacterRequest.self)
  }
}
