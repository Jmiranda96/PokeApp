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
    @IBOutlet weak var serachBar: UISearchBar!
    
    var model = PokemonModel()
    
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
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search By Number/Name/Type"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

}

extension PokemonViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    // TODO
  }
}

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as! PokemonTableViewCell
        
        let pokemonInfo = self.model.pokemonList[indexPath.row]
        
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
