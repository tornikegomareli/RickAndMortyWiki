//
//  EpisodeRepository.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 17.06.21.
//

import Resolver
import RxSwift

protocol EpisodeRepositoring {
  func getEpisodes() -> Observable<EpisodeRequest.Element>
}

class EpisodeRepository: EpisodeRepositoring {
  @Injected private var restClient: RestClient
  func getEpisodes() -> Observable<EpisodeRequest.Element> {
    return restClient.fetch(request: EpisodeRequest.self)
  }
}
