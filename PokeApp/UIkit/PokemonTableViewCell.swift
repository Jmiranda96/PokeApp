//
//  PokemonTableViewCell.swift
//  PokeApp
//
//  Created by Jorge Miranda on 26/08/20.
//  Copyright © 2020 Jorge Miranda. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var secondaryTitle: UILabel!
    @IBOutlet weak var mainType: UIImageView!
    @IBOutlet weak var secondaryType: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typesStack: UIStackView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.mainTitle.font = UIFont(name: "Avenir-Medium", size: 19)
        self.mainTitle.textColor = UIColor(red: 79.0/255.0, green: 79.0/255.0, blue: 79.0/255.0, alpha: 1)
        self.secondaryTitle.font = UIFont(name: "Avenir-Book", size: 15)
        self.secondaryTitle.textColor = UIColor(red: 164.0/255.0, green: 164.0/255.0, blue: 164.0/255.0, alpha: 1)
        self.descriptionLabel.font = UIFont(name: "Avenir-Book", size: 15)
        self.descriptionLabel.textColor = UIColor(red: 164.0/255.0, green: 164.0/255.0, blue: 164.0/255.0, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupPokemonCell(name: String, number: String, sprite: UIImage = #imageLiteral(resourceName: "Pokemon Icon"), types: [UIImage] = [#imageLiteral(resourceName: "Moves Icon"),#imageLiteral(resourceName: "Moves Icon")]){
        self.mainTitle.text = name
        self.secondaryTitle.text = "#"+number
        self.mainImage.image = sprite
        self.mainType.image = types[0]
        if types.count > 1 {
            self.secondaryType.image = types[1]
        } else {
            self.secondaryType.isHidden = true
        }
        self.descriptionLabel.removeFromSuperview()
    }
}
