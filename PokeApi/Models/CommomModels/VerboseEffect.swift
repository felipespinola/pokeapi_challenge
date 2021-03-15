//
//  VerboseEffect.swift
//  PokeApi
//
//  Created by Felipe Ramos on 14/03/21.
//

import Foundation
import Unrealm

struct VerboseEffect: Decodable, Realmable {
    //The localized effect text for an API resource in a specific language
    var effect: String = ""
    //The localized effect text in brief.
    var short_effect: String = ""
    //The language this effect is in
    var language: NamedAPIResource = NamedAPIResource()
}
