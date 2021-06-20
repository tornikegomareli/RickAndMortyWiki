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
  func getEpisodesByIds(ids: [String]) -> Observable<EpisodeRequest.Element>
  func netPage(page:String) -> Observable<EpisodeRequest.Element>
}

class EpisodeRepository: EpisodeRepositoring {
  @Injected private var restClient: RestClient
  func getEpisodes() -> Observable<EpisodeRequest.Element> {
    return restClient.fetch(request: EpisodeRequest.self)
  }
  
  func getEpisodesByIds(ids: [String]) -> Observable<EpisodeRequest.Element> {
    let episodeIds = ids.parseEpisodeId()
    return restClient.fetch(request: EpisodeRequest.self, withParamsInPath: episodeIds)
  }
  
  func netPage(page: String) -> Observable<EpisodeRequest.Element> {
    return restClient.fetch(request: EpisodeRequest.self, withParamsInPath: page)
  }
}


