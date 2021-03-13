//
//  PokemonAbility.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation

struct PokemonAbility: Decodable {
    //Whether or not this is a hidden ability
    var is_hidden: Bool
    //The slot this ability occupies in this Pokémon species
    var slot: Int
    //The ability the Pokémon may have
    var ability: NamedAPIResource
}
