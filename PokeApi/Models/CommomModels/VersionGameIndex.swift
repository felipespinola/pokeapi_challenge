//
//  VersionGameIndex.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation
import Unrealm

struct VersionGameIndex: Decodable, Realmable {
    //The internal id of an API resource within game data
    var game_index: Int = 0
    //The version relevent to this game index
    var version: NamedAPIResource = NamedAPIResource()
}
