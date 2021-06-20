//
//  EpisodesByCharacterViewModel.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 20.06.21.
//
//

import RxSwift
import Resolver


/// Main Protocol for ViewModel
/// Parents : EpisodesByCharacterViewModelInput, EpisodesByCharacterViewModelOutput
public protocol EpisodesByCharacterViewModel: EpisodesByCharacterViewModelInput, EpisodesByCharacterViewModelOutput {
}

/// Every parameter, which will be used by ViewController
public struct EpisodesByCharacterViewModelParams {
}

/// Input Protocol
/// Every method, event, delegate which will be called from ViewController -> ViewModel
public protocol EpisodesByCharacterViewModelInput {
  func viewDidLoad()
  func didRequestFetchByCharacter(ids: [String])
  func didRequestOnRowClick(model: Episode)
}

/// Output Protocol
/// action - Every action observable which will throwed by viewModel, viewController must subscribe
/// route  - every route observable where viewController can Navigate, viewController must subscribe
/// params - Object where will be all the parameter which viewController needs
public protocol EpisodesByCharacterViewModelOutput {
  var action: Observable<EpisodesByCharacterViewModelOutputAction> { get }
  var route: Observable<EpisodesByCharacterViewModelRoute> { get }
  var params: EpisodesByCharacterViewModelParams { get }
  var dataSource: SubjectRelay<[Episode]> { get }
  var allEpisodesData: [Episode] { get }

}

/// Enum types which will be throwed by action Observable
public enum EpisodesByCharacterViewModelOutputAction {
  case showIndicator
  case hideIndicator
}

/// Enum types which will be throwed by route Observable
public enum EpisodesByCharacterViewModelRoute {
  case routeToCharacters(model: Episode)
}

/// Default View Model Implementation
public class DefaultEpisodesByCharacterViewModel {
  @Injected var episodeRepository: MultipleRepositoring
  private let actionSubject = PublishSubject<EpisodesByCharacterViewModelOutputAction>()
  private var allEpisodeDataSource = [Episode]()
  private let routeSubject = PublishSubject<EpisodesByCharacterViewModelRoute>()
  public let params: EpisodesByCharacterViewModelParams = EpisodesByCharacterViewModelParams()
  public let dataSourceSubject: SubjectRelay<[Episode]> = SubjectRelay<[Episode]>(value: [])
}

/// Derived extension, all the properties will be used by viewController
extension DefaultEpisodesByCharacterViewModel: EpisodesByCharacterViewModel {
  public var action: Observable<EpisodesByCharacterViewModelOutputAction> { actionSubject.asObserver() }
  public var route: Observable<EpisodesByCharacterViewModelRoute> { routeSubject.asObserver() }
  public var allEpisodesData: [Episode] { allEpisodeDataSource }
  public var dataSource: SubjectRelay<[Episode]> {  dataSourceSubject }
  
  public func viewDidLoad() {
  }
  
  public func didRequestFetchByCharacter(ids: [String]) {
    actionSubject.onNext(.showIndicator)
    _ = episodeRepository.getEpisodesByIds(ids: ids)
      .subscribe { episodes in
        self.allEpisodeDataSource = episodes
        self.actionSubject.onNext(.hideIndicator)
        self.dataSource.accept(episodes)
      } onError: { error in
        print(error)
      }
  }
  
  public func didRequestOnRowClick(model: Episode) {
    routeSubject.onNext(.routeToCharacters(model: model))
  }
}

