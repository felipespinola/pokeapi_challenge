//
//  PokemonEvolutionChain.swift
//  PokeApi
//
//  Created by Felipe Ramos on 15/03/21.
//

import Foundation
import Unrealm

struct PokemonEvolutionChain: Decodable, Realmable {
    //The identifier for this resource.
    var id: Int = 0
    //The type the referenced Pokémon has
    var chain: ChainLink = ChainLink()
    
    static func primaryKey() -> String? {
        return "id"
    }
}

struct ChainLink: Decodable, Realmable {
    //The Pokémon species at this point in the evolution chain
    var species: NamedAPIResource = NamedAPIResource()
    //A List of chain objects
    var evolves_to: [ChainLink] = []
}

struct EvolutionDetail: Decodable, Realmable {
    //The Pokémon species at this point in the evolution chain
    var species: NamedAPIResource = NamedAPIResource()
    //A List of chain objects
    var evolves_to: [ChainLink] = []
}
