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
    
    func getAllPokemon(completion: @escaping (Bool) -> Void) {
        
        AF.request("\(Constants.baseURL)pokemon").responseJSON { response in
            guard let data = response.data else {
                print("No data")
                completion(false)
                return
            }
            
            do {
                let pokemonMainResponse = try JSONDecoder().decode(Pokemon.MainNetworkResponse.self, from: data)
                print(pokemonMainResponse)
                
                for pokemon in pokemonMainResponse.results {
                    self.getPokemon(url: pokemon.url)
                }
                
                completion(true)
                
            } catch let error {
                print("error: \(error)")
                completion(false)
            }
        }
    }
    
    func getPokemon(url: String){
        guard let url = URL(string: url) else {
            return
        }
        AF.request(url).responseJSON { response in
            guard let data = response.data else {
                print("No data")
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                RealmSingleton.shared.realm.beginWrite()
                RealmSingleton.shared.realm.add(pokemon, update: .all)
                try RealmSingleton.shared.realm.commitWrite()
            } catch let error {
                print("error: \(error)")
            }
        }
    }
}
