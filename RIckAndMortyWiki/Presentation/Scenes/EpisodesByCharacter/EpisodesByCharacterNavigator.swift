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

  /// Handles navigation type
  /// - Parameter viewController: View controller where to navigate
  /// - Parameter navigationType: Navigation type enum push, present or makeRoot
  /// - Parameter animate: Navigation with animation or without animation
  public func requestNavigation(to destination: EpisodesByCharacterViewModelRoute, animated animate: Bool) {
  }

  fileprivate func navigate(viewController: UIViewController, navigationType: NavigationType, animated: Bool) {

  }

}

