//
//  NamedAPIResource.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation

struct NamedAPIResource: Decodable {
    //The name of the referenced resource
    var name: String
    //The URL of the referenced resource
    var url: String
}
