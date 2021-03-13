//
//  RealmSingleton.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import Foundation
import RealmSwift

final class RealmSingleton {
    //Can't init is singleton
    private init() { }
    
    static let shared = RealmSingleton()
    
    var config = Realm.Configuration(
        schemaVersion: 1
    )
    
    lazy var realm: Realm = {
        Realm.Configuration.defaultConfiguration = config
        do {
            return try Realm(configuration: config)
        } catch let error {
            return try! Realm()
        }
    }()
}
