//
//  String+Extension.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 19.06.21.
//

import Foundation

extension Array where Element == String {
  func getIds() -> String {
    var idsSeperatedbyComma: String = ""
    self.forEach { url in
      let allSlashSubStrings = url.components(separatedBy: "/")
      let last = allSlashSubStrings.last
      if let safeLast = last {
        idsSeperatedbyComma.append("\(safeLast),")
      }
    }
    idsSeperatedbyComma.remove(at: idsSeperatedbyComma.lastIndex(of: idsSeperatedbyComma.last!)!)
    return idsSeperatedbyComma
  }
}

extension String {
  func parseNextPage() -> String {
    let allSubstringWithSlash = self.components(separatedBy: "?")
    let last = allSubstringWithSlash.last
    if let safeLast = last {
      return "?\(safeLast)"
    }
    return ""
  }
}
