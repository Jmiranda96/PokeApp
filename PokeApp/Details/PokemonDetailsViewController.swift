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
    var pokemonColor = UIColor.black
    
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

        statNumber.font = UIFont(name: "Avenir-Book", size: 14)
        statNumber.textColor = UIColor.black.withAlphaComponent(0.7)
        statNumber.text = String(format: "%03d", value)

        let statBarEmpty = UIView()
        statBarEmpty.backgroundColor = UIColor.lightGray
        statBarEmpty.layer.cornerRadius = 5
        statBarEmpty.clipsToBounds = true
        
        let statBarFill = UIView()
        statBarFill.backgroundColor = self.pokemonColor
        statBarFill.layer.cornerRadius = 5
        statBarFill.clipsToBounds = true
        
        
        view.addSubview(statName)
        view.addSubview(statNumber)
        view.addSubview(statBarEmpty)
        view.addSubview(statBarFill)
        
        statName.translatesAutoresizingMaskIntoConstraints = false
        statNumber.translatesAutoresizingMaskIntoConstraints = false
        statBarEmpty.translatesAutoresizingMaskIntoConstraints = false
        statBarFill.translatesAutoresizingMaskIntoConstraints = false
        
        statName.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        statName.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        statNumber.leftAnchor.constraint(equalTo: statName.rightAnchor, constant: 10).isActive = true
        statNumber.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        statBarEmpty.leftAnchor.constraint(equalTo: statNumber.rightAnchor, constant: 10).isActive = true
        statBarEmpty.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        statBarEmpty.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        statBarEmpty.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        statBarFill.leftAnchor.constraint(equalTo: statNumber.rightAnchor, constant: 10).isActive = true
        statBarFill.widthAnchor.constraint(equalToConstant: CGFloat(Double(value)*2.5)).isActive = true
//        statBarFill.widthAnchor.constraint(equalTo: statBarEmpty.widthAnchor, multiplier: CGFloat(value/100)).isActive = true
        statBarFill.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        statBarFill.heightAnchor.constraint(equalToConstant: 10).isActive = true
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
