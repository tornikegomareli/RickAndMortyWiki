//
//  CharactersNavigator.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 19.06.21.
//
//

import RxSwift

/// View Navigator
/// Responsiblity - Holds Navigation logic, between viewControllers
internal class CharactersNavigator: Navigator {
  /// ViewController reference, which owns navigator object
  private weak var viewController: UIViewController?
  public init(viewController: UIViewController) {
    self.viewController = viewController
  }

  /// Handles navigation type
  /// - Parameter viewController: View controller where to navigate
  /// - Parameter navigationType: Navigation type enum push, present or makeRoot
  /// - Parameter animate: Navigation with animation or without animation
  public func requestNavigation(to destination: CharactersViewModelRoute, animated animate: Bool) {
    switch destination {
      case .toEpisodeByCharacter(let model):
        let vC = EpisodesByCharacterViewController.instantiate(from: "EpisodesByCharacter")
        vC.character = model
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


