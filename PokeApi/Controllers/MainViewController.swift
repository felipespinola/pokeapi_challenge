//
//  MainViewController.swift
//  PokeApi
//
//  Created by Felipe Ramos on 13/03/21.
//

import UIKit
import RealmSwift
import SDWebImage
import Hero

class MainViewController: UIViewController {
    
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    
    var pokemons: [Pokemon.PokemonSimpleResult] = []
    var isLoading = false
    var nextListOfPokemonsUrl = ""
    var loadingView: LoadingReusableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupCollectionView()
        
        let search = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = search
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        
        Webservices().getAllPokemon(url: "\(Constants.baseURL)pokemon") { result in
            if let next = result?.next {
                if next != "" {
                    self.nextListOfPokemonsUrl = next
                }
            }
            self.pokemons.append(contentsOf: result?.results ?? [])
            self.pokemonCollectionView.reloadData()
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
        
        self.navigationController?.hero.navigationAnimationType = .fade
    }
    
    func setupCollectionView() {
        //Register Loading Reuseable View
        let loadingReusableNib = UINib(nibName: "LoadingReusableView", bundle: nil)
        pokemonCollectionView.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "LoadingReusableView")
        
        self.isLoading = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPokemonDetailSegue" {
            guard let pokemon = sender as? Pokemon.PokemonSimpleResult else { return }
            if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.pokemonSimple = pokemon
            }
        }
    }
    
    

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonSimpleCollectionViewCell", for: indexPath) as! PokemonSimpleCollectionViewCell
        //Set pokemon name
        cell.pokemonNameLabel.text = pokemons[indexPath.row].name.capitalizingFirstLetter()
        cell.pokemonNameLabel.hero.id = "pokemonName"
        
        //Set pokemon number
        let idFromUrl = String(pokemons[indexPath.row].url.split(separator: "/").last ?? "")
        let idInt: Int = Int(idFromUrl) ?? 0
        cell.pokemonNumberLabel.text = String(format: "Nº %03d", arguments: [idInt])

        //Set pokemon image
        cell.pokemonImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.pokemonImageView.sd_setImage(with: URL(string: "\(Constants.officialArtworkBaseURL)\(idFromUrl).png"), placeholderImage: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.row]
        
        self.performSegue(withIdentifier: "goToPokemonDetailSegue", sender: pokemon)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == pokemons.count - 1 && !self.isLoading {
            loadMoreData()
        }
    }
    
    func loadMoreData() {
        print("Load more data")
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().async {
                Webservices().getAllPokemon(url: self.nextListOfPokemonsUrl) { result in
                    if let next = result?.next {
                        if next != "" {
                            self.nextListOfPokemonsUrl = next
                        }
                    }
                    self.isLoading = false
                    self.pokemons.append(contentsOf: result?.results ?? [])
                    self.pokemonCollectionView.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let sectionFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LoadingReusableView", for: indexPath) as! LoadingReusableView
            loadingView = sectionFooter
            loadingView?.backgroundColor = UIColor.clear
            return sectionFooter
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            //Start animating
            self.loadingView?.activityIndicator.startAnimating()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            //Stop animating
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
}

extension UIViewController {
    open override func awakeFromNib() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
