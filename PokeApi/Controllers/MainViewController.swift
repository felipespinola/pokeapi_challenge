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
    
    var pokemons: [Pokemon] = Array(RealmSingleton.shared.realm.objects(Pokemon.self))
    @IBOutlet weak var pokemonCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        
        
        var search = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = search
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        
        Webservices().getAllPokemon() { result in
            if result {
                // Success
                self.pokemons = Array(RealmSingleton.shared.realm.objects(Pokemon.self))
                self.pokemonCollectionView.reloadData()
            }
        }
    }
    
    func setupNavigationBar() {
        let image = UIImage(named: "pokemon.png")
        let imageView = UIImageView(image:image)
        
        let bannerWidth = self.navigationController?.navigationBar.frame.size.width ?? self.view.frame.width
        let bannerHeight = self.navigationController?.navigationBar.frame.size.height ?? self.view.frame.height
        let bannerX = bannerWidth  / 2 - (image?.size.width)! / 2
        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        
        self.navigationItem.titleView = imageView
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
        
        //Set pokemon number
        if let id = pokemons[indexPath.row].id {
            cell.pokemonNumberLabel.text = String(format: "Nº %03d", arguments: [id])
            
            //Set pokemon image
            cell.pokemonImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.pokemonImageView.sd_setImage(with: URL(string: "\(Constants.officialArtworkBaseURL)\(id).png"), placeholderImage: nil)
        }
        
        
        
        
        
        return cell
    }
    
    
    
}
