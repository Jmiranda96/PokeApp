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
                
                pokemons.results?.forEach({ (poke) in
                    
                    let pokeResource = poke as! PKMNamedAPIResource
                    self.getPokemonDetails(name: pokeResource.name!)
                })
                
                DispatchQueue.main.async {
                    self.delegate.updateList()
                }
                
                break
                    
            case .failure(_): break
                
            }
        }
    }
    
    func getPokemonDetails(name: String) {
        pokeAPI.pokemonService.fetchPokemon(name) { result in
            switch result {
            case .success(let pokemon):
                
                var types = [String]()
                    
                pokemon.types?.forEach({ (pokeType) in
                    types.append((pokeType.type?.name)!)
                })
                
                self.pokemonList.append(PokemonInfo(name: pokemon.name!.capitalized, spriteURL: pokemon.sprites!.frontDefault!, types: types , number: pokemon.id!))
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
