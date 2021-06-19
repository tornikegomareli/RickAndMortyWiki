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
  func netPage(page:String) -> Observable<EpisodeRequest.Element>
}

class EpisodeRepository: EpisodeRepositoring {
  func netPage(page: String) -> Observable<EpisodeRequest.Element> {
    return restClient.fetch(request: EpisodeRequest.self, withParamsInPath: page)
  }
  
  @Injected private var restClient: RestClient
  func getEpisodes() -> Observable<EpisodeRequest.Element> {
    return restClient.fetch(request: EpisodeRequest.self)
  }
}

