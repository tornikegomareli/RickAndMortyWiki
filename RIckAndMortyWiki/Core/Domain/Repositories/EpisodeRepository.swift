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
  @Injected private var restClient: RestClient
  func getEpisodes() -> Observable<EpisodeRequest.Element> {
    return restClient.fetch(request: EpisodeRequest.self)
  }
  
  func netPage(page: String) -> Observable<EpisodeRequest.Element> {
    return restClient.fetch(request: EpisodeRequest.self, withParamsInPath: page)
  }
}

protocol MultipleRepositoring {
  func getEpisodesByIds(ids: [String]) -> Observable<MultipleEpisodeRequest.Element>
}

class MultipleEpisodeRepository: MultipleRepositoring {
  @Injected private var restClient: RestClient

  func getEpisodesByIds(ids: [String]) -> Observable<MultipleEpisodeRequest.Element> {
    let episodeIds = ids.parseEpisodeId()
    return restClient.fetch(request: MultipleEpisodeRequest.self, withParamsInPath: episodeIds)
  }
}



