//
//  Webservice.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation
import Alamofire

class Webservices {
    
    func getAllPokemon() {
        
        AF.request("\(Constants.baseURL)pokemon").responseJSON { response in
            guard let data = response.data else {
                print("No data")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Pokemon.MainNetworkResponse.self, from: data)
                print(result)
                
                for pokemon in result.results {
                    self.getPokemon(url: pokemon.url)
                }
                
            } catch let error {
                print("error: \(error)")
            }
        }
    }
    
    func getPokemon(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        AF.request(url).responseJSON { response in
            guard let data = response.data else {
                print("No data")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Pokemon.self, from: data)
                print(result)
            } catch let error {
                print("error: \(error)")
            }
        }
    }
}
