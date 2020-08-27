//
//  PokemonViewController.swift
//  PokeApp
//
//  Created by Jorge Miranda on 26/08/20.
//  Copyright © 2020 Jorge Miranda. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    struct data {
        var image: String
        var name: String
        var number: String
    }
    
    let dataList: [data] = [
        data(image: "", name: "Title 1", number: "001"),
        data(image: "", name: "Title 2", number: "002"),
        data(image: "", name: "Title 3", number: "003")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        let nib = UINib(nibName: "PokemonTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PokemonTableViewCell")

        
        
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

}

extension PokemonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonTableViewCell", for: indexPath) as! PokemonTableViewCell
        
        if indexPath.row == 1 {
            let img: UIImage = #imageLiteral(resourceName: "Items Icon")
            cell.setupPokemonCell(name: self.dataList[indexPath.row].name, number: self.dataList[indexPath.row].number, types: [img] )
        } else {
            cell.setupPokemonCell(name: self.dataList[indexPath.row].name, number: self.dataList[indexPath.row].number )
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
}
