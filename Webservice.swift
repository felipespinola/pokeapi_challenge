//
//  Webservice.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation
import Alamofire
import RealmSwift

class Webservices {
    
    func getAllPokemons() {
        //pokemon?limit=1118
        let cacher = ResponseCacher(behavior: .cache)
        AF.request("\(Constants.baseURL)pokemon?limit=1118")
            .cacheResponse(using: cacher)
            .responseJSON { response in
            guard let data = response.data else {
                print("No data")
                return
            }
            
            do {
                let pokemonMainResponse = try JSONDecoder().decode(Pokemon.MainNetworkResponse.self, from: data)

                for pokemon in pokemonMainResponse.results {
                    RealmSingleton.shared.realm.beginWrite()
                    RealmSingleton.shared.realm.add(pokemon, update: .all)
                    try RealmSingleton.shared.realm.commitWrite()
                    //self.getPokemon(url: pokemon.url)
                }
            } catch let error {
                print("error: \(error)")
            }
        }
    }
    
    func get20MorePokemons(url: String, completion: @escaping (Pokemon.MainNetworkResponse?) -> Void) {
        AF.request(url).responseJSON { response in
            guard let data = response.data else {
                print("No data")
                completion(nil)
                return
            }
            
            do {
                let pokemonMainResponse = try JSONDecoder().decode(Pokemon.MainNetworkResponse.self, from: data)
                
                for pokemon in pokemonMainResponse.results {
                    RealmSingleton.shared.realm.beginWrite()
                    RealmSingleton.shared.realm.add(pokemon, update: .all)
                    try RealmSingleton.shared.realm.commitWrite()
                    //self.getPokemon(url: pokemon.url)
                }
                
                completion(pokemonMainResponse)
                
            } catch let error {
                print("error: \(error)")
                completion(nil)
            }
        }
    }
    
    func getPokemon(url: String, completion: @escaping (Pokemon?) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        AF.request(url).responseJSON { response in
            guard let data = response.data else {
                print("No data")
                completion(nil)
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(pokemon)
                RealmSingleton.shared.realm.beginWrite()
                RealmSingleton.shared.realm.add(pokemon, update: .all)
                try RealmSingleton.shared.realm.commitWrite()
            } catch let error {
                print("error: \(error)")
                completion(nil)
            }
        }
    }
    
    func getAbility(url: String, completion: @escaping (PokemonDetailAbility?) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        AF.request(url).responseJSON { response in
            guard let data = response.data else {
                print("No data")
                completion(nil)
                return
            }
            
            do {
                let ability = try JSONDecoder().decode(PokemonDetailAbility.self, from: data)
                completion(ability)
                RealmSingleton.shared.realm.beginWrite()
                RealmSingleton.shared.realm.add(ability, update: .all)
                try RealmSingleton.shared.realm.commitWrite()
            } catch let error {
                print("error: \(error)")
                completion(nil)
            }
        }
    }
    
    func getType(url: String, completion: @escaping (PokemonTypeDetail?) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        AF.request(url).responseJSON { response in
            guard let data = response.data else {
                print("No data")
                completion(nil)
                return
            }
            
            do {
                let typePokemon = try JSONDecoder().decode(PokemonTypeDetail.self, from: data)
                completion(typePokemon)
                print(typePokemon)
                RealmSingleton.shared.realm.beginWrite()
                RealmSingleton.shared.realm.add(typePokemon, update: .all)
                try RealmSingleton.shared.realm.commitWrite()
            } catch let error {
                print("error: \(error)")
                completion(nil)
            }
        }
    }
}
