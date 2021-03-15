//
//  Pokemon.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation
import Unrealm

struct Pokemon: Decodable, Realmable {
    
    //The identifier for this resource
    var id: Int?
    //The name for this resource
    var name: String = ""
    //The base experience gained for defeating this Pokémon
    var base_experience: Int = 0
    //The height of this Pokémon in decimetres
    var height: Int = 0
    //Set for exactly one Pokémon used as the default for each species
    var is_default: Bool = false
    //Order for sorting. Almost national order, except families are grouped together
    var order: Int = 0
    //The weight of this Pokémon in hectograms
    var weight: Int = 0
    //A list of abilities this Pokémon could potentially have
    var abilities: [PokemonAbility] = []
    //A list of forms this Pokémon can take on
    var forms: [NamedAPIResource] = []
    //A list of game indices relevent to Pokémon item by generation
    var game_indices: [VersionGameIndex] = []
    //A list of items this Pokémon may be holding when encountered
    var held_items: [PokemonHeldItem] = []
    //A link to a list of location areas, as well as encounter details pertaining to specific versions
    var location_area_encounters: String = ""
    //A list of moves along with learn methods and level details pertaining to specific version groups
    var moves: [PokemonMove] = []
    //A set of sprites used to depict this Pokémon in the game. A visual representation of the various sprites can be found at PokeAPI/sprites
    var sprites: PokemonSprites = PokemonSprites()
    //The species this Pokémon belongs to
    var species: NamedAPIResource = NamedAPIResource()
    //A list of base stat values for this Pokémon
    var stats: [PokemonStat] = []
    //A list of details showing types this Pokémon has
    var types: [PokemonType] = []
    
    static func primaryKey() -> String? {
        return "id"
    }
    
    
}


extension Pokemon {
    struct MainNetworkResponse: Decodable, Realmable {
        var count: Int = 0
        var next: String?
        var previous: String?
        var results: [PokemonSimpleResult] = []
    }
    
    struct PokemonSimpleResult: Decodable, Realmable {
        var name: String = ""
        var url: String = ""
        
        static func primaryKey() -> String? {
            return "name"
        }
    }
    
    struct TypePokemon: Decodable, Realmable {
        //The order the Pokémon's types are listed in
        var slot: Int = 0
        //The Pokémon that has the referenced type
        var pokemon: PokemonSimpleResult = PokemonSimpleResult()
    }
}
