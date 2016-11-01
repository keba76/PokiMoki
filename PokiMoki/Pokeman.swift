//
//  Pokeman.swift
//  PokiMoki
//
//  Created by Ievgen Keba on 10/31/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokeID: Int!
    
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
