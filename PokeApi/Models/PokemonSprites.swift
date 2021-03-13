//
//  PokemonSprites.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation

struct PokemonSprites: Decodable {
    //The default depiction of this Pokémon from the front in battle
    var front_default: String?
    //The shiny depiction of this Pokémon from the front in battle
    var front_shiny: String?
    //The female depiction of this Pokémon from the front in battle
    var front_female: String?
    //The shiny female depiction of this Pokémon from the front in battle
    var front_shiny_female: String?
    //The default depiction of this Pokémon from the back in battle
    var back_default: String?
    //The shiny depiction of this Pokémon from the back in battle
    var back_shiny: String?
    //The female depiction of this Pokémon from the back in battle
    var back_female: String?
    //The shiny female depiction of this Pokémon from the back in battle
    var back_shiny_female: String?
}
