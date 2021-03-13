//
//  PokemonStat.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation

struct PokemonStat: Decodable {
    //The stat the Pokémon has
    var stat: NamedAPIResource
    //The effort points (EV) the Pokémon has in the stat
    var effort: Int
    //The base value of the stat
    var base_stat: Int
}
