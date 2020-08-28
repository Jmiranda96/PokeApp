//
//  PokemonModel.swift
//  PokeApp
//
//  Created by Jorge Miranda on 26/08/20.
//  Copyright © 2020 Jorge Miranda. All rights reserved.
//

import Foundation
import PokemonAPI

protocol PokemonDelegate {
    func updateList()
}

struct PokemonInfo {
    var name: String
    var spriteURL: String
    var types: [String]
    var number: Int
    var stats: [Int]
}

class PokemonModel {
    
    let pokeAPI = PokemonAPI()
    var pagedObject: PKMPagedObject<PKMPokemon>!
    var delegate: PokemonDelegate!
    var pokemonInfo: PokemonInfo!
    var pokemonList = [PokemonInfo]()
    
    
    func getPokemonList() {
        pokeAPI.pokemonService.fetchPokemonList(paginationState: .initial(pageLimit: 150)) { result in
            switch result {
            case .success(let pokemons):
                self.pagedObject = pokemons
                
                
                self.loadList()
                
                break
                    
            case .failure(_): break
                
            }
        }
    }
    
    
    func loadList(index: Int = 0){
        
        guard index <= self.pagedObject.results!.count-1 else {
            return
        }
        
        let pokemon = self.pagedObject.results![index] as! PKMNamedAPIResource
        
        getPokemonDetails(name: pokemon.name! ) { (success) in
            self.publishPokemonList()
            guard success else {
                return
            }
            self.loadList(index: index+1)
        }
    }
    
    
    func getPokemonDetails(name: String, completion: @escaping (Bool) -> Void) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.pokeAPI.pokemonService.fetchPokemon(name) { result in
                switch result {
                case .success(let pokemon):
                    
                    var types = [String]()
                        
                    pokemon.types?.forEach({ (pokeType) in
                        types.append((pokeType.type?.name)!)
                    })
                    
                    var stats = [Int]()
                    pokemon.stats?.forEach({ (pokeStats) in
                        stats.append(pokeStats.baseStat!)
                    })
                    
                    self.pokemonList.append(PokemonInfo(name: pokemon.name!.capitalized, spriteURL: pokemon.sprites!.frontDefault!, types: types , number: pokemon.id!, stats: stats))

                    completion(true)
                    
                case .failure(let error):
                    completion(false)
                    print(error.localizedDescription)
                }
            }
        }
    }

    
    func publishPokemonList(by: String = ""){
        DispatchQueue.main.async {
            self.pokemonList.sort { (Poke1, Poke2) -> Bool in
                return Poke1.number < Poke2.number
            }
            self.delegate.updateList()
        }
    }
    
}
