//
//  UIImageView+Extension.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 17.06.21.
//

import UIKit

extension UIImageView {
  func makeRounded() {
    self.layer.borderWidth = 0
    self.layer.masksToBounds = false
    self.layer.borderColor = UIColor.clear.cgColor
    self.layer.cornerRadius = self.frame.height / 2
    self.clipsToBounds = true
  }
}

