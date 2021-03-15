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

struct PokemonDetailAbility: Decodable, Realmable {
    //The identifier for this resource.
    var id: Int = 0
    //The name for this resource
    var name: String = ""
    //Whether or not this ability originated in the main series of the video games
    //var is_main_series: Bool = false
    //The generation this ability originated in
    //var generation: NamedAPIResource = NamedAPIResource()
    //The name of this resource listed in different languages
    //var names: [Name] = []
    //The effect of this ability listed in different languages
    var effect_entries: [VerboseEffect] = []
    
    static func primaryKey() -> String? {
        return "id"
    }
}
