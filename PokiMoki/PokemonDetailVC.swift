//
//  PokemonDetailVC.swift
//  PokiMoki
//
//  Created by Ievgen Keba on 11/1/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    // Instantiate from seque
    var pokemon: Pokemon!
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokeIDLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLbl.text = pokemon.name.capitalized
        let img = UIImage(named: String(pokemon.pokeID))
        self.mainImg.image = img
        self.currentEvoImg.image = img
        self.defenceLbl.text = pokemon.defence
        self.pokeIDLbl.text = String(pokemon.pokeID)
        pokemon.downloadPokemonDetail {
            //rewrw
            self.updateUI()
        }

    }

    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func updateUI() {
        self.attackLbl.text = pokemon.attack
        self.defenceLbl.text = pokemon.defence
        self.heightLbl.text = pokemon.height
        self.weightLbl.text = pokemon.weight
        self.typeLbl.text = pokemon.type
        self.descriptionLbl.text = pokemon.description
        if pokemon.nextEvolutionID == "" {
            self.evoLbl.text = "No Evolution"
            self.nextEvoImg.isHidden = true
        } else {
            self.nextEvoImg.isHidden = false
            self.nextEvoImg.image = UIImage(named: pokemon.nextEvolutionID)
            let str = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLvl)"
            self.evoLbl.text = str
        }
    }

}
