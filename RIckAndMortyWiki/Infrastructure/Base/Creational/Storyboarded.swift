//
//  StoryBoarded.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 17.06.21.
//

import UIKit

protocol Storyboarded {
  static func instantiate(from: String) -> Self
}

extension Storyboarded where Self: UIViewController {
  static func instantiate(from:String) -> Self {
    let id = String(describing: self)
    let storyboard = UIStoryboard(name: from, bundle: Bundle.main)
    return storyboard.instantiateViewController(identifier: id) as! Self
  }
}
