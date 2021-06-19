//
//  UIViewController+Extensions.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 19.06.21.
//

import UIKit

extension UIViewController {
    // see ObjectAssociation<T> class below
    private static let association = ObjectAssociation<UIActivityIndicatorView>()

    var indicator: UIActivityIndicatorView {
        set { UIViewController.association[self] = newValue }
        get {
            if let indicator = UIViewController.association[self] {
                return indicator
            } else {
                UIViewController.association[self] = UIActivityIndicatorView.customIndicator(at: self.view.center)
                return UIViewController.association[self]!
            }
        }
    }

    // MARK: - Acitivity Indicator
    public func startIndicatingActivity() {
        DispatchQueue.main.async {
            self.view.addSubview(self.indicator)
            self.indicator.startAnimating()
            //UIApplication.shared.beginIgnoringInteractionEvents() // if desired
        }
    }

    public func stopIndicatingActivity() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
            //UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
}

