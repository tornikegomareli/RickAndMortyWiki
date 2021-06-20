//
//  AppDelegate+Injection+Extension.swift
//  RIckAndMortyWiki
//
//  Created by Tornike Gomareli on 17.06.21.
//

import Resolver

/// Resolves extension to register all services
extension Resolver: ResolverRegistering {
  /// Resolver automatically calls the registerAllServices function the very first time it's asked to resolve a particular service.
  /// But as is, it's not very useful until you actually register some classes.
  public static func registerAllServices() {
    Resolver.register { RestClient() }.scope(.shared)
    Resolver.register { CharacterRepository() as CharacterRepositoring }.scope(.shared)
    Resolver.register { EpisodeRepository() as EpisodeRepositoring }.scope(.shared)
    Resolver.register { LocationRepository() as LocationRepositoring }.scope(.shared)
    Resolver.register { MultipleEpisodeRepository() as MultipleRepositoring }.scope(.shared)
  }
}
