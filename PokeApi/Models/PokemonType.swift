//
//  PokemonType.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation

struct PokemonType: Decodable {
    //The order the Pokémon's types are listed in
    var slot: Int
    //The type the referenced Pokémon has
    var type: NamedAPIResource
}
