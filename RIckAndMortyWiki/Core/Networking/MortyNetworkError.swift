//
//  MortyNetworkingError.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 16.06.21.
//
import Foundation
import UIKit

enum MortyNetworkError: Swift.Error {
  case dataIsNil
  case networkConnectionLost
  case generalError
}

extension MortyNetworkError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .dataIsNil:
      return NSLocalizedString("Data is empty", comment: "")
    case .networkConnectionLost:
      return NSLocalizedString("Network lost, try again", comment: "")
    case .generalError:
      return NSLocalizedString("Oops we slipped, sorry, try again", comment: "")
    }
  }
}

extension MortyNetworkError: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(errorDescription)
  }
}

extension MortyNetworkError: Equatable {
  static func == (lhs: MortyNetworkError, rhs: MortyNetworkError) -> Bool {
    return lhs.errorDescription == rhs.errorDescription
  }
}

public struct ErrorDescription {
  public var image: UIImage?
  public var title: String
  public var message: String?
  public var buttonTitle: String
}

public extension Error {
  func transform() -> Error {
    switch self {
    case _ where (self as NSError).code == -1009:
      return MortyNetworkError.networkConnectionLost
    default:
      return MortyNetworkError.generalError
    }
  }

  var description: ErrorDescription {
    let general = ErrorDescription(image: nil, title: "Oops", message: "We slipped, sorry, try again", buttonTitle: "Retry")

    guard let error = self as? MortyNetworkError else {
      return general
    }

    switch error {
    case MortyNetworkError.networkConnectionLost:
      return ErrorDescription(image: nil, title: "No Internet", message: "Check your internet connection", buttonTitle: "Retry")
    default:
      return general
    }
  }
}
