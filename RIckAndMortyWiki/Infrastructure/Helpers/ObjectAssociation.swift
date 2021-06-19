//
//  ObjectAssociation.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 19.06.21.
//

import Foundation

public final class ObjectAssociation<T: AnyObject> {
  private let policy: objc_AssociationPolicy
  public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
    self.policy = policy
  }

  public subscript(index: AnyObject) -> T? {
    get { return objc_getAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque()) as! T? }
    set { objc_setAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque(), newValue, policy) }
  }
}
