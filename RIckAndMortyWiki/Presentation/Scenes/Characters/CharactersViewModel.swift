//
//  CharactersViewModel.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 19.06.21.
//
//

import RxSwift
import Resolver

/// Main Protocol for ViewModel
/// Parents : CharactersViewModelInput, CharactersViewModelOutput
public protocol CharactersViewModel: CharactersViewModelInput, CharactersViewModelOutput {
}

/// Every parameter, which will be used by ViewController
public struct CharactersViewModelParams {
}

/// Input Protocol
/// Every method, event, delegate which will be called from ViewController -> ViewModel
public protocol CharactersViewModelInput {
  func viewDidLoad()
  func viewDidLoad(withParam: Episode)
  func didRequestNavigationToEpisodesByCharacter(model: MultipleCharacter)
}

/// Output Protocol
/// action - Every action observable which will throwed by viewModel, viewController must subscribe
/// route  - every route observable where viewController can Navigate, viewController must subscribe
/// params - Object where will be all the parameter which viewController needs
public protocol CharactersViewModelOutput {
  var action: Observable<CharactersViewModelOutputAction> { get }
  var route: Observable<CharactersViewModelRoute> { get }
  var params: CharactersViewModelParams { get }
  var dataSource: SubjectRelay<[MultipleCharacter]> { get }
  var allCharactersData: [MultipleCharacter] { get set }
}

/// Enum types which will be throwed by action Observable
public enum CharactersViewModelOutputAction {
  case showIndicator
  case hideIndicator
}

/// Enum types which will be throwed by route Observable
public enum CharactersViewModelRoute {
  case toEpisodeByCharacter(model: MultipleCharacter)
}

/// Default View Model Implementation
public class DefaultCharactersViewModel {
  @Injected private var repository:CharacterRepositoring
  private let actionSubject = PublishSubject<CharactersViewModelOutputAction>()
  private let routeSubject = PublishSubject<CharactersViewModelRoute>()
  private var allCharactersSource = [MultipleCharacter]()
  public let params: CharactersViewModelParams = CharactersViewModelParams()
  public let dataSource = SubjectRelay<[MultipleCharacter]>(value: [])
}

/// Derived extension, all the properties will be used by viewController
extension DefaultCharactersViewModel: CharactersViewModel {
  public var allCharactersData: [MultipleCharacter] {
    get {
      return allCharactersSource
    }
    set {
      allCharactersSource = newValue
    }
  }
  public var action: Observable<CharactersViewModelOutputAction> { actionSubject.asObserver() }
  public var route: Observable<CharactersViewModelRoute> { routeSubject.asObserver() }
  public var dataSourceSubject: SubjectRelay<[MultipleCharacter]> { dataSource }

    
  public func viewDidLoad() {
  }
  
  public func viewDidLoad(withParam: Episode) {
    fetchCharactersByEpisode(episode: withParam)
  }
  
  private func fetchCharactersByEpisode(episode: Episode) {
    let ids = episode.characters.getIds()
    actionSubject.onNext(.showIndicator)
    _ = repository.getMultipleCharacters(ids: ids)
        .subscribe(onNext: { result in
          self.allCharactersData = result
          self.actionSubject.onNext(.hideIndicator)
          self.dataSource.accept(result)
        },
        onError: { error in
          print(error)
        },
        onCompleted: {
          self.actionSubject.onNext(.hideIndicator)
        })
    }
  
    public func didRequestNavigationToEpisodesByCharacter(model: MultipleCharacter) {
      routeSubject.onNext(.toEpisodeByCharacter(model: model))
    }
}



