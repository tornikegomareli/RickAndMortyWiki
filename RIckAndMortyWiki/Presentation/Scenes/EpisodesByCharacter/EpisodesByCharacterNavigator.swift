//
//  EpisodesByCharacterNavigator.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 20.06.21.
//  
//

import RxSwift

/// View Navigator
/// Responsiblity - Holds Navigation logic, between viewControllers
internal class EpisodesByCharacterNavigator: Navigator {
  /// ViewController reference, which owns navigator object
  private weak var viewController: UIViewController?
  public init(viewController: UIViewController) {
    self.viewController = viewController
  }
  /// All the destination types, where viewController can navigate
  public enum Destination {

  }

  public func requestNavigation(to destination: EpisodesByCharacterViewModelRoute, animated animate: Bool) {
    switch destination {
      case .routeToCharacters(let episode):
        let vC = CharactersViewController.instantiate(from: "Characters")
        vC.episode = episode
        navigate(viewController: vC, navigationType: .push, animated: true)
      }
  }

  fileprivate func navigate(viewController: UIViewController, navigationType: NavigationType, animated: Bool) {
    switch navigationType {
      case .makeAsRoot:
        break
      case .present:
        self.viewController?.present(viewController, animated: true, completion: nil)
      case .push:
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        self.viewController?.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.viewController?.navigationController?.pushViewController(viewController, animated: true)
        break
    }
  }
}

