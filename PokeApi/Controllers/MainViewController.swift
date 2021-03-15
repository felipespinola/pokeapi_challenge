//
//  MainViewController.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Webservices().getAllPokemon()
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonSimpleCollectionViewCell", for: indexPath) as! PokemonSimpleCollectionViewCell
        
        return cell
    }
    
    
    
}
