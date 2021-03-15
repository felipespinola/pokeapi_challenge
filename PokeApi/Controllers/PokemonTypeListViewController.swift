//
//  PokemonTypeListViewController.swift
//  PokeApi
//
//  Created by Felipe Ramos on 15/03/21.
//

import UIKit
import SDWebImage

class PokemonTypeListViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    @IBOutlet weak var typeTitleLabel: UILabel!
    
    var pokemons: [Pokemon.TypePokemon] = []
    var typeName: String = ""
    var type: PokemonType = PokemonType()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        typeTitleLabel.text = "\(type.type.name.capitalizingFirstLetter()) type - Pokémons"
        
        Webservices().getType(url: type.type.url) { result in
            //result.
            if let typeResult = result {
                print(typeResult)
                self.pokemons = typeResult.pokemon
                self.pokemonCollectionView.reloadData()
            }
        }
        
        pokemonCollectionView.delegate = self
        pokemonCollectionView.dataSource = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PokemonTypeListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonSimpleCollectionViewCell", for: indexPath) as! PokemonSimpleCollectionViewCell
        print(pokemons[indexPath.row].pokemon)
        //Set pokemon name
        cell.pokemonNameLabel.text = pokemons[indexPath.row].pokemon.name.capitalizingFirstLetter()
        cell.pokemonNameLabel.hero.id = "pokemonName"
        
        //Set pokemon number
        let idFromUrl = String(pokemons[indexPath.row].pokemon.url.split(separator: "/").last ?? "")
        let idInt: Int = Int(idFromUrl) ?? 0
        cell.pokemonNumberLabel.text = String(format: "Nº %03d", arguments: [idInt])
        cell.pokemonNumberLabel.hero.id = "pokemonNumber"

        //Set pokemon image
        cell.pokemonImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.pokemonImageView.sd_setImage(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(idFromUrl).png"), placeholderImage: nil)
        cell.pokemonImageView.hero.id = "pokemonImage"
        return cell
    }
    
    
}
