//
//  PokemonType.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation
import Unrealm

struct PokemonType: Decodable, Realmable {
    //The order the Pokémon's types are listed in
    var slot: Int = 0
    //The type the referenced Pokémon has
    var type: NamedAPIResource = NamedAPIResource()
}
