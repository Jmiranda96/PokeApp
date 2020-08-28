//
//  PokemonViewController.swift
//  PokeApp
//
//  Created by Jorge Miranda on 26/08/20.
//  Copyright © 2020 Jorge Miranda. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, PokemonDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var model = PokemonModel()
    var filteredPokemons = [PokemonInfo]()
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBarSetup()
        
        model.getPokemonList()
        let nib = UINib(nibName: "PokemonTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PokemonTableViewCell")
        
        
        model.delegate = self
        
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "pokemonDetails" {
            if let vc = segue.destination as? PokemonDetailsViewController {
                
                let selectedIndex = self.tableView!.indexPathForSelectedRow!
                
                let selectedCell = self.tableView.cellForRow(at: selectedIndex) as! PokemonTableViewCell
                vc.pokemonInfo = model.pokemonList[selectedIndex.row]
                vc.pokemonImage = selectedCell.mainImage.image!
            }
        }
    }
    
    
    // MARK: - PokemonDelegate
    func updateList() {
        self.tableView.reloadData()
    }
    
    func searchBarSetup(){
        self.navigationItem.title = "Pokemom's Index"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Number/Name/Type"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        self.filteredPokemons = model.pokemonList.filter({ (pokemon: PokemonInfo) -> Bool in
            
            let byName = pokemon.name.lowercased().contains(searchText.lowercased())
            
            var byNumber: Bool = false
            if let searchNumber = Int(searchText) {
                byNumber = pokemon.number == searchNumber
            }
            
            let byType = pokemon.types.contains(searchText.lowercased())
            
            
            return byName || byNumber || byType
        })

        tableView.reloadData()
    }
      

}

extension PokemonViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
          return filteredPokemons.count
        }
        return self.model.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as! PokemonTableViewCell
        
        let pokemonInfo = isFiltering ? filteredPokemons[indexPath.row] : self.model.pokemonList[indexPath.row]
        
        cell.setupPokemonCell(name: pokemonInfo.name, number: pokemonInfo.number, sprite: pokemonInfo.spriteURL, types: pokemonInfo.types)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "pokemonDetails", sender: nil)
    }
    
    
}
