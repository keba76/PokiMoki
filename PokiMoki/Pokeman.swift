//
//  Pokeman.swift
//  PokiMoki
//
//  Created by Ievgen Keba on 10/31/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import Foundation

class Pokemon {
    
    private var _name: String!
    private var _pokeID: Int!
    
    private var _description: String!
    private var _type: String!
    private var _defence: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    
    
    var name: String {
        return _name
    }
    var pokeID: Int {
        return _pokeID
    }
    
    init(name: String, pokeID: Int) {
        self._name = name
        self._pokeID = pokeID
    }
}
