//
//  PokeCell.swift
//  PokiMoki
//
//  Created by Ievgen Keba on 10/31/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var tambImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon) {
        
        self.pokemon = pokemon
        self.nameLbl.text = self.pokemon.name.capitalized
        self.tambImg.image = UIImage(named: "\(self.pokemon.pokeID)")
    }
    
}
