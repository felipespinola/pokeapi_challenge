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
    var copyPokemons: [Pokemon.PokemonSimpleResult] = []
    var isLoading = false
    var isSearching = false
    var nextListOfPokemonsUrl = ""
    var loadingView: LoadingReusableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNavigationBar()
        setupCollectionView()
        
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Search Pokemon name or number"
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        
        Webservices().get20MorePokemons(url: "\(Constants.baseURL)pokemon") { result in
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

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.count == 0 {
            self.isSearching = false
        } else {
            self.isSearching = true
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let queryText = searchBar.text else { return }
        
        //Check if the query was a string or a number
        if Int(queryText) != nil {
            //Number
            var filterPokemons = Array(RealmSingleton.shared.realm.objects(Pokemon.PokemonSimpleResult.self))
            filterPokemons = filterPokemons.sorted(by: ({$0.url.split(separator: "/").last ?? "0" < $1.url.split(separator: "/").last ?? "0"}))
            filterPokemons = filterPokemons.filter {($0.url.split(separator: "/").last?.contains(queryText.lowercased()))!}
            self.pokemons = filterPokemons
        } else {
            //Name
            var filterPokemons = Array(RealmSingleton.shared.realm.objects(Pokemon.PokemonSimpleResult.self)).sorted(by: ({$0.url < $1.url}))
            filterPokemons = filterPokemons.filter {$0.name.contains(queryText.lowercased())}
            self.pokemons = filterPokemons
        }
        pokemonCollectionView.reloadData()
        self.isSearching = false
        searchBar.resignFirstResponder()
        navigationItem.searchController?.isActive = false
        navigationItem.searchController?.searchBar.prompt = queryText
        navigationItem.searchController?.searchBar.searchTextField.text = queryText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationItem.searchController?.resignFirstResponder()
        clearSearch()
    }
    
    func clearSearch() {
        self.isSearching = false
        Webservices().get20MorePokemons(url: "\(Constants.baseURL)pokemon") { result in
            if let next = result?.next {
                if next != "" {
                    self.nextListOfPokemonsUrl = next
                }
            }
            self.pokemons = []
            self.pokemons.append(contentsOf: result?.results ?? [])
            self.pokemonCollectionView.reloadData()
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
        
        cell.pokemonNumberLabel.hero.id = "pokemonNumber"

        //Set pokemon image
        cell.pokemonImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.pokemonImageView.sd_setImage(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(idFromUrl).png"), placeholderImage: nil)
        cell.pokemonImageView.hero.id = "pokemonImage"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        detailVC.hero.modalAnimationType = .selectBy(presenting: .slide(direction: .left), dismissing: .slide(direction: .right))
        detailVC.pokemonSimple = pokemon
        detailVC.pokemonNumber = Int(String(pokemons[indexPath.row].url.split(separator: "/").last ?? "")) ?? 0
        self.present(detailVC, animated: true, completion: nil)
        //self.performSegue(withIdentifier: "goToPokemonDetailSegue", sender: pokemon)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == pokemons.count - 1 && !self.isLoading && (!self.isSearching && self.navigationItem.searchController?.searchBar.searchTextField.text == "") {
            loadMoreData()
        }
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().async {
                Webservices().get20MorePokemons(url: self.nextListOfPokemonsUrl) { result in
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
        if self.isLoading || !self.isSearching {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionFooter) {
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
