//
//  PokemonDetailsModel.swift
//  PokeApp
//
//  Created by Jorge Miranda on 27/08/20.
//  Copyright © 2020 Jorge Miranda. All rights reserved.
//

import Foundation
import PokemonAPI

protocol PokemonDetailProtocol {
    func setDescription()
}

class PokemonDetailsModel {
    
    let pokeAPI = PokemonAPI()
    
    struct PokemonInfo {
        var name: String
        var spriteURL: String
        var types: [String]
        var number: Int
    }
    
    var typesColor = [
        "bug": UIColor(red: 164/255, green: 196/255, blue: 78/255, alpha: 1),
        "electric": UIColor(red: 247/255, green: 221/255, blue: 116/255, alpha: 1),
        "fire": UIColor(red: 254/255, green: 163/255, blue: 90/255, alpha: 1),
        "grass": UIColor(red: 81/255, green: 189/255, blue: 107/255, alpha: 1),
        "shadow": UIColor(red: 102/255, green: 106/255, blue: 120/255, alpha: 1),
        "fairy": UIColor(red: 245/255, green: 160/255, blue: 226/255, alpha: 1),
        "flying": UIColor(red: 150/255, green: 175/255, blue: 221/255, alpha: 1),
        "ground": UIColor(red: 219/255, green: 129/255, blue: 89/255, alpha: 1),
        "dragon": UIColor(red: 0/255, green: 121/255, blue: 194/255, alpha: 1),
        "fighting": UIColor(red: 220/255, green: 65/255, blue: 91/255, alpha: 1),
        "ghost": UIColor(red: 93/255, green: 110/255, blue: 178/255, alpha: 1),
        "ice": UIColor(red: 114/255, green: 210/255, blue: 198/255, alpha: 1),
        "normal": UIColor(red: 154/255, green: 158/255, blue: 161/255, alpha: 1),
        "rock": UIColor(red: 203/255, green: 188/255, blue: 145/255, alpha: 1),
        "poison": UIColor(red: 184/255, green: 100/255, blue: 199/255, alpha: 1),
        "steel": UIColor(red: 80/255, green: 150/255, blue: 162/255, alpha: 1),
        "psychic": UIColor(red: 255/255, green: 133/255, blue: 131/255, alpha: 1),
        "water": UIColor(red: 81/255, green: 160/255, blue: 244/255, alpha: 1),
        
    
    
    ]
    
    var pokeDescription = String()
    var delegate: PokemonDetailProtocol!
    
    
    func getPokeDescription(pokeID: Int) {
        PokemonAPI().gameService.fetchPokedex(1) { result in
            switch result {
            case .success(let pokedex):
                print(pokedex.name!) // kalos-mountain
                
                PokemonAPI().resourceService.fetch((pokedex.pokemonEntries?[pokeID-1].pokemonSpecies)!) { result in
                    switch result {
                    case .success(let region):
                        self.pokeDescription = region.flavorTextEntries![7].flavorText!
                        self.delegate.setDescription()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getPokeColor(type: String) -> UIColor {
        return typesColor[type]!
    }
    
    
}

