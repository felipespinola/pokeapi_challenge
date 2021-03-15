//
//  PokemonStat.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation
import Unrealm

struct PokemonStat: Decodable, Realmable {
    //The stat the Pokémon has
    var stat: NamedAPIResource = NamedAPIResource()
    //The effort points (EV) the Pokémon has in the stat
    var effort: Int = 0
    //The base value of the stat
    var base_stat: Int = 0
}
