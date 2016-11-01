//
//  ViewController.swift
//  PokiMoki
//
//  Created by Ievgen Keba on 10/31/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokenon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        parsePokemonCSV()
        initAudio()
        
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    func initAudio() {
        let path = Bundle.main.path(forResource: "113", ofType: "mp3")!
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV() {
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokemon = Pokemon(name: row["identifier"]!, pokeID: Int(row["id"]!)!)
                pokenon.append(pokemon)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            if inSearchMode {
                let poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke)
                return cell
            } else {
                let pokemon = pokenon[indexPath.row]
                cell.configureCell(pokemon)
                return cell
            }
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke: Pokemon!
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokenon[indexPath.row]
        }
        performSegue(withIdentifier: "pokemonDetail", sender: poke)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pokemonDetail" {
            if let detailsVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    detailsVC.pokemon = poke
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokenon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.4
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collection.reloadData()
            // disappear keyboard
            view.endEditing(true)
        } else {
            inSearchMode = true
            let lower = searchBar.text?.lowercased()
            filteredPokemon = pokenon.filter{$0.name.range(of: lower!) != nil}
            collection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

