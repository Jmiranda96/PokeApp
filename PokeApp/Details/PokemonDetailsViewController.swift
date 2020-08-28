//
//  PokemonDetailsViewController.swift
//  PokeApp
//
//  Created by Jorge Miranda on 27/08/20.
//  Copyright © 2020 Jorge Miranda. All rights reserved.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var pokemonDescription: UILabel!
    @IBOutlet weak var statsStack: UIStackView!
    //
    @IBOutlet weak var backGroundView: UIView!
    
    var pokemonImage = UIImage()
    var pokemonName = String()
    var pokemonColor = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundLayer()
        self.mainImage.image = pokemonImage
//
//
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        setupStats()
    }
    
    override func viewWillLayoutSubviews() {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func backgroundLayer(){
        let layer = CAGradientLayer()
        layer.frame = backGroundView.bounds
        layer.colors = [UIColor.yellow.cgColor, UIColor.green.cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x:1, y:0.5)
        backGroundView.layer.addSublayer(layer)
        self.backGroundView.bringSubviewToFront(self.mainView)
        self.backGroundView.bringSubviewToFront(self.mainImage)

        self.mainView.layer.cornerRadius = 48
        self.mainView.clipsToBounds = true
        self.mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setupStats() {
        
        self.statsStack.addArrangedSubview(getStatsBar())
        self.statsStack.addArrangedSubview(getStatsBar())
        self.statsStack.addArrangedSubview(getStatsBar())
        self.statsStack.addArrangedSubview(getStatsBar())
       
    }

    
    func getStatsBar(name: String = "DMG", value: Int = 50) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.heightAnchor.constraint(equalToConstant: 20).isActive = true
        view.backgroundColor = UIColor.clear
        let statName = UILabel()
        
        statName.font = UIFont(name: "Avenir-Heavy", size: 12)
        statName.textColor = self.pokemonColor
        statName.text = name
        
        let statNumber = UILabel()
        
        statNumber.font = UIFont(name: "Avenir-Book", size: 12)
        
        
        
        return view
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
