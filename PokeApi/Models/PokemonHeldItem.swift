//
//  PokemonHeldItem.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation
import Unrealm

struct PokemonHeldItem: Decodable, Realmable {
    //The item the referenced Pokémon holds
    var item: NamedAPIResource = NamedAPIResource()
    //The details of the different versions in which the item is held
    var version_details: [PokemonHeldItemVersion] = []
}

struct PokemonHeldItemVersion: Decodable, Realmable {
    //The version in which the item is held
    var version: NamedAPIResource = NamedAPIResource()
    //How often the item is held
    var rarity: Int = 0
}
