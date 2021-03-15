//
//  APIResource.swift
//  PokeApi
//
//  Created by Felipe Ramos on 15/03/21.
//

import Foundation
import Unrealm

struct APIResource: Decodable, Realmable {
    //The URL of the referenced resource
    var url: String = ""
}
