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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        model.getPokemonList()
        let nib = UINib(nibName: "PokemonTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PokemonTableViewCell")
        
        
        model.delegate = self
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - PokemonDelegate
    func updateList() {
        self.tableView.reloadData()
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
    
    
}
