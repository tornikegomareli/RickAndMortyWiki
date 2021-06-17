//
//  BaseNavigationController.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 17.06.21.
//

import UIKit

class BaseNavigationController: UINavigationController {
  var onDismissBlock: (() -> Void)?
  open override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    if isBeingDismissed {
      onDismissBlock?()
    }
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
  }
}
