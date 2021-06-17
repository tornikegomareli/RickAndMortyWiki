//
//  SubjectRelay .swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 17.06.21.
//

import RxSwift

/// RxSwift BehaviorRelay clone with value setter. Must be used only in storage wrappers
public final class SubjectRelay<Element>: ObservableType {
  public var value: Element {
    get {
      return try! subject.value()
    }
    set(newValue) {
      accept(newValue)
    }
  }

  private let subject: BehaviorSubject<Element>
  
  public func accept(_ event: Element) {
    subject.onNext(event)
  }
  
  public init(value: Element) {
    subject = BehaviorSubject(value: value)
  }
  
  public func subscribe<Observer: ObserverType>(_ observer: Observer) -> Disposable where Observer.Element == Element {
    subject.subscribe(observer)
  }
  
  public func asObservable() -> Observable<Element> {
    subject.asObservable()
  }
}
