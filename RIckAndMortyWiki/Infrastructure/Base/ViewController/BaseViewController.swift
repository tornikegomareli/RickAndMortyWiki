//
//  BaseViewController.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 17.06.21.
//

import RxSwift

open class BaseViewController: UIViewController {
  var onDismissBlock: (() -> Void)?
  let disposeBag = DisposeBag()

  override open func viewDidLoad() {
    super.viewDidLoad()
  }
  
  open func hideNavigationBarIfNeeded(isNeeded: Bool, animated: Bool) {
    navigationController?.setNavigationBarHidden(isNeeded, animated: animated)
  }
  
  open func makeNavigationbarTransperent() {
    self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
  }
  
  override open func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    if isBeingDismissed {
      onDismissBlock?()
    }
  }
}
