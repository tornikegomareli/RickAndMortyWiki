//
//  EpisodesViewModel.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 17.06.21.
//  
//

import RxSwift
import Resolver

/// Main Protocol for ViewModel
/// Parents : EpisodesViewModelInput, EpisodesViewModelOutput
public protocol EpisodesViewModel: EpisodesViewModelInput, EpisodesViewModelOutput {
}

/// Every parameter, which will be used by ViewController
public struct EpisodesViewModelParams {
}

/// Input Protocol
/// Every method, event, delegate which will be called from ViewController -> ViewModel
public protocol EpisodesViewModelInput {
  func viewDidLoad()
}

/// Output Protocol
/// action - Every action observable which will throwed by viewModel, viewController must subscribe
/// route  - every route observable where viewController can Navigate, viewController must subscribe
/// params - Object where will be all the parameter which viewController needs
public protocol EpisodesViewModelOutput {
  var action: Observable<EpisodesViewModelOutputAction> { get }
  var route: Observable<EpisodesViewModelRoute> { get }
  var dataSource: SubjectRelay<[Episode]> { get }
  var params: EpisodesViewModelParams { get }
}

/// Enum types which will be throwed by action Observable
public enum EpisodesViewModelOutputAction {
  case showIndicator
  case hideIndicator
}

/// Enum types which will be throwed by route Observable
public enum EpisodesViewModelRoute {
}

/// Default View Model Implementation
public class DefaultEpisodesViewModel {
  @Injected private var repository:EpisodeRepositoring
  
  private let actionSubject = PublishSubject<EpisodesViewModelOutputAction>()
  private let routeSubject = PublishSubject<EpisodesViewModelRoute>()
  private let dataSourceSubject = SubjectRelay<[Episode]>(value: [])
  public let params: EpisodesViewModelParams = EpisodesViewModelParams()
}

/// Derived extension, all the properties will be used by viewController
extension DefaultEpisodesViewModel: EpisodesViewModel {
  public var action: Observable<EpisodesViewModelOutputAction> { actionSubject.asObserver() }
  public var route: Observable<EpisodesViewModelRoute> { routeSubject.asObserver() }
  public var dataSource: SubjectRelay<[Episode]> { dataSourceSubject }

  public func viewDidLoad() {
    fetchEpisodes()
  }
  
  private func fetchEpisodes() {
    actionSubject.onNext(.showIndicator)
    _ = repository.getEpisodes()
        .subscribe(onNext: { result in
          self.actionSubject.onNext(.hideIndicator)
          self.dataSourceSubject.accept(result.results)
        },
        onError: { error in
          print(error)
        },
        onCompleted: {
          self.actionSubject.onNext(.hideIndicator)
        })
  }
}
