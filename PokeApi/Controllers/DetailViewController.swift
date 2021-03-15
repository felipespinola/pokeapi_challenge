//
//  DetailViewController.swift
//  PokeApi
//
//  Created by Felipe Ramos on 14/03/21.
//

import UIKit
import ImageSlideshow
import Hero
import Charts

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonNumberLabel: UILabel!
    
    @IBOutlet weak var pokemonStatsHorizontalBarChartView: HorizontalBarChartView!
    var pokemonSimple: Pokemon.PokemonSimpleResult = Pokemon.PokemonSimpleResult()
    var pokemonNumber: Int = 0
    var pokemon: Pokemon = Pokemon()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pokemonNameLabel.text = pokemonSimple.name.capitalizingFirstLetter()
        pokemonNameLabel.hero.id = "pokemonName"
        
        pokemonNumberLabel.text = String(format: "Nº %03d", arguments: [pokemonNumber])
        pokemonNumberLabel.hero.id = "pokemonNumber"
        
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
        
        imageSlideshow.hero.id = "pokemonImage"
        
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
        
        //Sprites
        loadSpritesToCarousel()
        //Stats
        loadStats()
        //Abilities
        loadAbilities()
    }
    
    // MARK: - Sprites
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
    
    // MARK: - Stats
    func loadStats() {
        pokemonStatsHorizontalBarChartView.noDataText = "Can't get stats for this Pokemon. Try again later"
        pokemonStatsHorizontalBarChartView.pinchZoomEnabled = false
        pokemonStatsHorizontalBarChartView.doubleTapToZoomEnabled = false
        
        var chartDataEntry = [BarChartDataEntry]()
        
        for i in 0..<pokemon.stats.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(pokemon.stats[i].base_stat))
            chartDataEntry.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: chartDataEntry, label: "Base Stat Value")
        //chartDataSet.drawValuesEnabled = true
        chartDataSet.colors = ChartColorTemplates.colorful()

        let chartMain = BarChartData()
        chartMain.barWidth = 0.2

        chartMain.addDataSet(chartDataSet)
        pokemonStatsHorizontalBarChartView.animate(yAxisDuration: 0.5)
        pokemonStatsHorizontalBarChartView.data = chartMain
        
        pokemonStatsHorizontalBarChartView.xAxis.labelCount = chartDataSet.count
        
        configureCharts()
    }
    
    func configureCharts() {
        //Setup xAxis
        pokemonStatsHorizontalBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: pokemon.stats.map {$0.stat.name})
        pokemonStatsHorizontalBarChartView.xAxis.granularity = 1.0
        pokemonStatsHorizontalBarChartView.xAxis.labelPosition = .bottom
        pokemonStatsHorizontalBarChartView.xAxis.drawGridLinesEnabled = false
        pokemonStatsHorizontalBarChartView.xAxis.axisMinimum = 0
        pokemonStatsHorizontalBarChartView.xAxis.axisLineColor = .clear
        pokemonStatsHorizontalBarChartView.xAxis.drawAxisLineEnabled = false
        pokemonStatsHorizontalBarChartView.leftAxis.labelPosition = .insideChart
        pokemonStatsHorizontalBarChartView.leftAxis.enabled = false
        pokemonStatsHorizontalBarChartView.leftAxis.axisMinimum = 0
        pokemonStatsHorizontalBarChartView.leftAxis.drawGridLinesEnabled = false
        pokemonStatsHorizontalBarChartView.minOffset = 10
        
        //Setup yAxis
        pokemonStatsHorizontalBarChartView.rightAxis.drawGridLinesEnabled = false
        pokemonStatsHorizontalBarChartView.rightAxis.drawZeroLineEnabled = false
        pokemonStatsHorizontalBarChartView.rightAxis.spaceBottom = 10
        pokemonStatsHorizontalBarChartView.rightAxis.granularity = 1.0
        pokemonStatsHorizontalBarChartView.rightAxis.axisMinimum = 0.0
        pokemonStatsHorizontalBarChartView.rightAxis.axisLineColor = .clear
        
        //Disable gestures
        pokemonStatsHorizontalBarChartView.pinchZoomEnabled = false
        pokemonStatsHorizontalBarChartView.doubleTapToZoomEnabled = false
        pokemonStatsHorizontalBarChartView.scaleXEnabled = false
        pokemonStatsHorizontalBarChartView.scaleYEnabled = false
        
        //Setup chart
        pokemonStatsHorizontalBarChartView.drawBordersEnabled = false
        pokemonStatsHorizontalBarChartView.drawValueAboveBarEnabled = true
        pokemonStatsHorizontalBarChartView.drawGridBackgroundEnabled = false
        pokemonStatsHorizontalBarChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        pokemonStatsHorizontalBarChartView.extraRightOffset = 20
        pokemonStatsHorizontalBarChartView.extraBottomOffset = 30
        pokemonStatsHorizontalBarChartView.fitScreen()
        pokemonStatsHorizontalBarChartView.notifyDataSetChanged()

        guard let description = pokemonStatsHorizontalBarChartView.chartDescription else {return}
        description.text = ""
    }
    
    // MARK: - Abilities
    func loadAbilities() {
        
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
