//
//  Pokemon.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation

struct Pokemon: Decodable {
    
    
}

extension Pokemon {
    struct MainNetworkResponse: Decodable {
        var count: Int
        var next: String?
        var previous: String?
        var results: [PokemonSimpleResult]
    }
    
    struct PokemonSimpleResult: Decodable {
        var name: String
        var url: String
    }
}
