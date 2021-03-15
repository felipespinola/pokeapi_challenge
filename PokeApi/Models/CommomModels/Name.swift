//
//  Name.swift
//  PokeApi
//
//  Created by Felipe Ramos on 14/03/21.
//

import Foundation
import Unrealm

struct Name: Decodable, Realmable {
    //The localized name for an API resource in a specific language
    var name: String = ""
    //The language this name is in
    var language: NamedAPIResource = NamedAPIResource()
}

