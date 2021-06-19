//
//  UIView+Extension.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 17.06.21.
//

import UIKit

extension UIView {
  @IBInspectable
  var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
      layer.masksToBounds = newValue > 0
    }
  }
  
  @IBInspectable
  var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable
  var borderColor: UIColor? {
    get {
      let color = UIColor.init(cgColor: layer.borderColor!)
      return color
    }
    set {
      layer.borderColor = newValue?.cgColor
    }
  }
  
  @IBInspectable
  var shadowRadius: CGFloat {
    get {
      return layer.shadowRadius
    }
    set {
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOffset = CGSize(width: 0, height: 2)
      layer.shadowOpacity = 0.4
      layer.shadowRadius = shadowRadius
    }
  }
}

extension UIView {
  func roundCorners(corners: UIRectCorner, radius: CGFloat) {
     let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
     let mask = CAShapeLayer()
     mask.path = path.cgPath
     layer.mask = mask
  }
  
  func roundCorners() {
    self.layer.cornerRadius = 20.0
    self.layer.shadowColor = UIColor.gray.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    self.layer.shadowRadius = 7.0
    self.layer.shadowOpacity = 0.4
  }
}
