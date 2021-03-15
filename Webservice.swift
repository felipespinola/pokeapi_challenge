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
    
    func getAllPokemon(url: String, completion: @escaping (Pokemon.MainNetworkResponse?) -> Void) {
        AF.request(url).responseJSON { response in
            guard let data = response.data else {
                print("No data")
                completion(nil)
                return
            }
            
            do {
                let pokemonMainResponse = try JSONDecoder().decode(Pokemon.MainNetworkResponse.self, from: data)
                
                for pokemon in pokemonMainResponse.results {
                    print(pokemon)
                    RealmSingleton.shared.realm.beginWrite()
                    RealmSingleton.shared.realm.add(pokemon)
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
}
