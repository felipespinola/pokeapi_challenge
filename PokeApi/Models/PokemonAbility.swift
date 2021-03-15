//
//  PokemonAbility.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation
import Unrealm

struct PokemonAbility: Decodable, Realmable {
    //Whether or not this is a hidden ability
    var is_hidden: Bool = false
    //The slot this ability occupies in this Pokémon species
    var slot: Int = 0
    //The ability the Pokémon may have
    var ability: NamedAPIResource = NamedAPIResource()
}