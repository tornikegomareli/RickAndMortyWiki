//
//  UIActivityIndicator+Extension.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 19.06.21.
//

import UIKit

extension UIActivityIndicatorView {
    public static func customIndicator(at center: CGPoint) -> UIActivityIndicatorView {
      let indicator = UIActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
      indicator.layer.cornerRadius = 10
      indicator.center = center
      indicator.hidesWhenStopped = true
      indicator.style = UIActivityIndicatorView.Style.large
      indicator.backgroundColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 0.5)
      return indicator
    }
}
