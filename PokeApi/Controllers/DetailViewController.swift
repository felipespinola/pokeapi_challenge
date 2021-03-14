//
//  DetailViewController.swift
//  PokeApi
//
//  Created by Felipe Ramos on 14/03/21.
//

import UIKit
import ImageSlideshow
import Hero

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    var pokemonSimple: Pokemon.PokemonSimpleResult = Pokemon.PokemonSimpleResult()
    var pokemon: Pokemon = Pokemon()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pokemonNameLabel.text = pokemonSimple.name.capitalizingFirstLetter()
        pokemonNameLabel.hero.id = "pokemonName"
        
        imageSlideshow.zoomEnabled = false
        imageSlideshow.circular = false
        imageSlideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        imageSlideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor.black
        pageIndicator.pageIndicatorTintColor = UIColor.lightGray
        imageSlideshow.pageIndicator = pageIndicator
        
        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        imageSlideshow.activityIndicator = DefaultActivityIndicator()
        imageSlideshow.delegate = self
        
        print(pokemonSimple.name)
        Webservices().getPokemon(url: pokemonSimple.url) { result in
            if let pokemon = result {
                self.pokemon = pokemon
                
                self.setupView()
            }
        }
    }
    
    func setupView() {
        pokemonNameLabel.text = pokemon.name.capitalizingFirstLetter()
        
        loadSpritesToCarousel()
    }
    
    func loadSpritesToCarousel() {
        var arrayOfValidSprites: [InputSource] = []
        if let front_default = pokemon.sprites.front_default {
            arrayOfValidSprites.append(SDWebImageSource(urlString: front_default)!)
        }
        if let front_female = pokemon.sprites.front_female {
            arrayOfValidSprites.append(SDWebImageSource(urlString: front_female)!)
        }
        if let front_shiny = pokemon.sprites.front_shiny {
            arrayOfValidSprites.append(SDWebImageSource(urlString: front_shiny)!)
        }
        if let front_shiny_female = pokemon.sprites.front_shiny_female {
            arrayOfValidSprites.append(SDWebImageSource(urlString: front_shiny_female)!)
        }
        if let back_default = pokemon.sprites.back_default {
            arrayOfValidSprites.append(SDWebImageSource(urlString: back_default)!)
        }
        if let back_female = pokemon.sprites.back_female {
            arrayOfValidSprites.append(SDWebImageSource(urlString: back_female)!)
        }
        if let back_shiny = pokemon.sprites.back_shiny {
            arrayOfValidSprites.append(SDWebImageSource(urlString: back_shiny)!)
        }
        if let back_shiny_female = pokemon.sprites.back_shiny_female {
            arrayOfValidSprites.append(SDWebImageSource(urlString: back_shiny_female)!)
        }
        imageSlideshow.setImageInputs(arrayOfValidSprites)
    }
    
    @objc func closedView() {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
}
