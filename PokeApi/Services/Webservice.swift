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
    
    let cacher = ResponseCacher(behavior: .cache)
    
    func getAllPokemons() {
        //pokemon?limit=1118
        AF.request("\(Constants.baseURL)pokemon?limit=1118")
            .cacheResponse(using: cacher)
            .validate()
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
                }
            } catch let error {
                print("error: \(error)")
            }
        }
    }
    
    func get20MorePokemons(url: String, completion: @escaping (Pokemon.MainNetworkResponse?) -> Void) {
        AF.request(url)
            .cacheResponse(using: cacher)
            .validate()
            .responseJSON { response in
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
        AF.request(url)
            .cacheResponse(using: cacher)
            .validate()
            .responseJSON { response in
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
    
    func getPokemonSpecies(url: String, completion: @escaping (Pokemon.Species?) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        AF.request(url)
            .cacheResponse(using: cacher)
            .validate()
            .responseJSON { response in
            guard let data = response.data else {
                print("No data")
                completion(nil)
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.Species.self, from: data)
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
    
    // MARK: - Ability
    
    func getAbility(url: String, completion: @escaping (PokemonDetailAbility?) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        AF.request(url)
            .cacheResponse(using: cacher)
            .validate()
            .responseJSON { response in
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
    
    // MARK: - Type
    
    func getType(url: String, completion: @escaping (PokemonTypeDetail?) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        AF.request(url)
            .cacheResponse(using: cacher)
            .validate()
            .responseJSON { response in
            guard let data = response.data else {
                print("No data")
                completion(nil)
                return
            }
            
            do {
                let typePokemon = try JSONDecoder().decode(PokemonTypeDetail.self, from: data)
                completion(typePokemon)
                RealmSingleton.shared.realm.beginWrite()
                RealmSingleton.shared.realm.add(typePokemon, update: .all)
                try RealmSingleton.shared.realm.commitWrite()
            } catch let error {
                print("error: \(error)")
                completion(nil)
            }
        }
    }
    
    // MARK: - Evolutions
    func getEvolutionChain(url: String, completion: @escaping (PokemonEvolutionChain?) -> Void) {
        print(url)
        guard let url = URL(string: url) else {
            return
        }
        AF.request(url)
            .cacheResponse(using: cacher)
            .validate()
            .responseJSON { response in
            guard let data = response.data else {
                print("No data")
                completion(nil)
                return
            }
            
            do {
                let evolutionChain = try JSONDecoder().decode(PokemonEvolutionChain.self, from: data)
                completion(evolutionChain)
                print(evolutionChain)
                RealmSingleton.shared.realm.beginWrite()
                RealmSingleton.shared.realm.add(evolutionChain, update: .all)
                try RealmSingleton.shared.realm.commitWrite()
            } catch let error {
                print("error: \(error)")
                completion(nil)
            }
        }
    }
}
