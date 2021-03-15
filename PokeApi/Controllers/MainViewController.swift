//
//  MainViewController.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import UIKit
import RealmSwift
import SDWebImage

class MainViewController: UIViewController {
    
    var pokemons: [Pokemon] = []
    @IBOutlet weak var pokemonCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Webservices().getAllPokemon() { result in
            if result {
                // Success
                self.pokemons = Array(RealmSingleton.shared.realm.objects(Pokemon.self))
                self.pokemonCollectionView.reloadData()
            }
        }
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonSimpleCollectionViewCell", for: indexPath) as! PokemonSimpleCollectionViewCell
        print(pokemons[indexPath.row].name)
        //Set pokemon name
        cell.pokemonNameLabel.text = pokemons[indexPath.row].name
        
        //Set pokemon image
        cell.pokemonImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        if let urlString = pokemons[indexPath.row].sprites.front_default {
            cell.pokemonImageView.sd_setImage(with: URL(string: urlString), placeholderImage: nil)
        }
        return cell
    }
    
    
    
}
