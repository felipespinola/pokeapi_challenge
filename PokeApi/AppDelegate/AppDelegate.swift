//
//  AppDelegate.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import UIKit
import Unrealm
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Realm.registerRealmables(Pokemon.self, Pokemon.PokemonSimpleResult.self, NamedAPIResource.self, VersionGameIndex.self, PokemonAbility.self, PokemonHeldItem.self, PokemonHeldItemVersion.self, PokemonMove.self, PokemonMoveVersion.self, PokemonStat.self, PokemonSprites.self, PokemonType.self, PokemonDetailAbility.self, VerboseEffect.self, PokemonTypeDetail.self, Pokemon.TypePokemon.self, PokemonEvolutionChain.self, ChainLink.self, EvolutionDetail.self, Pokemon.Species.self, Pokemon.SpeciesVariety.self, APIResource.self)
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = .white
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        } else {
            UINavigationBar.appearance().barTintColor = .white
            UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
        Webservices().getAllPokemons()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

