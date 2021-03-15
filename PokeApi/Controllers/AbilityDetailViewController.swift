//
//  AbilityDetailViewController.swift
//  PokeApi
//
//  Created by Felipe Ramos on 14/03/21.
//

import UIKit

class AbilityDetailViewController: UIViewController {
   
    @IBOutlet weak var abilityNameLabel: UILabel!
    @IBOutlet weak var abilityDescriptionLabel: UILabel!
    
    var ability: PokemonAbility = PokemonAbility()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: 200, height: 200)
        // Do any additional setup after loading the view.
        
        abilityNameLabel.text = ability.ability.name.capitalizingFirstLetter()
        abilityDescriptionLabel.text = ""
        
        Webservices().getAbility(url: ability.ability.url) { result in
            //result.
            if let abilities = result {
                for effect in abilities.effect_entries {
                    if effect.language.name == "en" {
                        self.abilityDescriptionLabel.text = effect.effect
                    }
                }
            }
        }
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
