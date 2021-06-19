//
//  Requestable.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 16.06.21.
//

import Alamofire
import RxSwift

enum RequestableResponseType {
  case json
}

protocol Requestable: URLRequestConvertible {
  associatedtype Element where Element: Decodable

  var expectedContentType: [String] { get }

  var basePath: String { get }

  var endpoint: String { get set }

  var httpMethod: HTTPMethod { get }

  var param: Parameters? { get }

  var addionalHeader: HeaderParameter? { get }

  var parameterEncoding: ParameterEncoding { get }

  func toObservable() -> Observable<Element>

  func decode(data: Data, type: RequestableResponseType) -> Element?

  func decodeError(response: DataResponse<Data, AFError>) -> MortyNetworkError

  init(param: Parameters?)
}

/// Conform URLConvitible from Alamofire
extension Requestable {
  func asURLRequest() -> URLRequest {
    return self.buildURLRequest()
  }
}

extension Requestable {
  var basePath: String {
    get {
      return "https://rickandmortyapi.com/api/"
    }
  }
}

// MARK: - Default implementation
extension Requestable {
  /// Variables
  typealias Parameters = [String: Any]
  typealias HeaderParameter = [String: String]
  typealias JSONDictionary = [String: Any]
  
  /// Response expected content type
  var expectedContentType: [String] {
    return  ["application/json"]
  }
  
  /// Param
  var param: Parameters? {
    return nil
  }
  
  /// Additional Header
  var addionalHeader: HeaderParameter? {
    return nil
  }

  /// Default headers array
  var defaultHeader: HeaderParameter {
    return [
      "Accept": "application/json",
    ]
  }

  /// Path
  var urlPath: String {
    return basePath + endpoint
  }
  
  /// URL
  var url: URL {
    return URL(string: urlPath)!
  }

  /// Encoode
  var parameterEncoding: ParameterEncoding {
    return URLEncoding.default
  }

  private func decodeJSON(data: Data) -> Element? {
    do {
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .custom { decoder in
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = formatter.date(from: dateString) {
          return date
        }
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: dateString) {
          return date
        }
        throw DecodingError.dataCorruptedError(in: container,
                                               debugDescription: "Cannot decode date string \(dateString)")
      }
      let object = try decoder.decode(Element.self, from: data)
      return object
    } catch let error {
      print("Could not decode \(error)")
      return nil
    }
  }
  
  func decode(data: Data, type: RequestableResponseType) -> Element? {
    return decodeJSON(data: data)
  }

  func decodeError(response: DataResponse<Data, AFError>) -> MortyNetworkError {
    if let data = response.data {
      if let decodedErrorObject = try? JSONDecoder().decode([String: String].self, from: data) {
        print("===== Request Error Result =====")
        dump(decodedErrorObject)
        print("===== Request Result Error End =====")
      }
    }
    return MortyNetworkError.generalError
  }
  
  func toObservable() -> Observable<Element> {
    guard let urlRequest = try? self.asURLRequest() else {
      return Observable.error(MortyNetworkError.generalError)
    }

    return Observable<Element>.create { observer -> Disposable in
      let requestReference = AF.request(urlRequest)
        .validate(statusCode: 200..<300)
        .validate(contentType: self.expectedContentType)
        .responseData(completionHandler: { response in
          if response.error != nil {
            observer.onError(self.decodeError(response: response))
            return
          }

          if let value = response.data {
            if let decodedElement = self.decode(data: value, type: .json) {
              observer.onNext(decodedElement)
              observer.onCompleted()
            } else {
              observer.onError(MortyNetworkError.generalError)
            }
          }
        })
      return Disposables.create(with: { requestReference.cancel() })
    }
  }

  // Build URL Request
  func buildURLRequest() -> URLRequest {
    // Init
    var urlRequest = URLRequest(url: self.url)
    urlRequest.httpMethod = self.httpMethod.rawValue
    urlRequest.timeoutInterval = TimeInterval(10 * 1000)

    // Encode param
    // swiftlint:disable force_try
    var request = try! self.parameterEncoding.encode(urlRequest, with: self.param)

    // Add addional Header if need
    for (key, value) in self.defaultHeader {
      request.addValue(value, forHTTPHeaderField: key)
    }

    // Add addional Header if need
    if let additinalHeaders = self.addionalHeader {
      for (key, value) in additinalHeaders {
        request.addValue(value, forHTTPHeaderField: key)
      }
    }

    return request
  }
}


