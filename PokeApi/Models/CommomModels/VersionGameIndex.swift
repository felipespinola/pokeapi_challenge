//
//  VersionGameIndex.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation

struct VersionGameIndex: Decodable {
    //The internal id of an API resource within game data
    var game_index: Int
    //The version relevent to this game index
    var version: NamedAPIResource
}
