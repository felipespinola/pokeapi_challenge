//
//  PokemonHeldItem.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation

struct PokemonHeldItem: Decodable {
    //The item the referenced Pokémon holds
    var item: NamedAPIResource
    //The details of the different versions in which the item is held
    var version_details: [PokemonHeldItemVersion]
}

struct PokemonHeldItemVersion: Decodable {
    //The version in which the item is held
    var version: NamedAPIResource
    //How often the item is held
    var rarity: Int
}
