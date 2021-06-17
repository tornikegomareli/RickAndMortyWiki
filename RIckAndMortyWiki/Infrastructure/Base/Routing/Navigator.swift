//
//  Navigator.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 17.06.21.
//
import Foundation

protocol Navigator {}

public enum NavigationType {
  case push
  case present
  case makeAsRoot
}
