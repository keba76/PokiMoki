//
//  Pokeman.swift
//  PokiMoki
//
//  Created by Ievgen Keba on 10/31/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import Foundation
import Alamofire

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
    private var _nextEvolutionName: String!
    private var _nextEvolutionID: String!
    private var _nextEvolutionLvl: String!
    
    private var _pokemonURL: String!
    
    var name: String {
        return _name
    }
    var pokeID: Int {
        return _pokeID
    }
    
    var defence: String {
        if _defence == nil {
            _defence = ""
        }
        return _defence
    }
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    var nextEvolutionID: String {
        if _nextEvolutionID == nil {
            _nextEvolutionID = ""
        }
        return _nextEvolutionID
    }
    var nextEvolutionLvl: String {
        if _nextEvolutionLvl == nil {
            _nextEvolutionLvl = ""
        }
        return _nextEvolutionLvl
    }
    
    
    init(name: String, pokeID: Int) {
        self._name = name
        self._pokeID = pokeID
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokeID)/"
        
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        Alamofire.request(self._pokemonURL).responseJSON { response in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = String(attack)
                }
                if let defence = dict["defense"] as? Int {
                    self._defence = String(defence)
                }
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                if let descriptions = dict["descriptions"] as? [Dictionary<String, String>], descriptions.count > 0 {
                    if let url = descriptions[0]["resource_uri"] {
                        let descURL = "\(URL_BASE)\(url)"
                        Alamofire.request(descURL).responseJSON { response in
                            if let descr = response.result.value as? Dictionary<String, AnyObject>{
                                if let description = descr["description"] as? String {
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "pokemon")
                                    self._description = newDescription
                                }
                            }
                            completed()
                        }
                    }
                } else {
                    self._description = ""
                }
                if let evolution = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolution.count > 0 {
                    if let nextEvo = evolution[0]["to"] as? String {
                        if nextEvo.range(of: "mega") == nil {
                            self._nextEvolutionName = nextEvo
                            if let uri = evolution[0]["resource_uri"] {
                                let ur = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let URI = ur.replacingOccurrences(of: "/", with: "")
                                self._nextEvolutionID = URI
                                
                                if let lvlExist = evolution[0]["level"] {
                                    if let lvl = lvlExist as? Int {
                                        self._nextEvolutionLvl = String(lvl)
                                    }
                                } else {
                                    self._nextEvolutionLvl = ""
                                }
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
}
