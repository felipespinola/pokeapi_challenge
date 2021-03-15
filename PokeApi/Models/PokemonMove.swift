//
//  PokemonMove.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation
import Unrealm

struct PokemonMove: Decodable, Realmable {
    //The move the Pokémon can learn
    var move: NamedAPIResource = NamedAPIResource()
    //The details of the version in which the Pokémon can learn the move
    var version_group_details: [PokemonMoveVersion] = []
}

struct PokemonMoveVersion: Decodable, Realmable {
    //The method by which the move is learned
    var move_learn_method: NamedAPIResource = NamedAPIResource()
    //The version group in which the move is learned
    var version_group: NamedAPIResource = NamedAPIResource()
    //The minimum level to learn the move
    var level_learned_at: Int = 0
}
