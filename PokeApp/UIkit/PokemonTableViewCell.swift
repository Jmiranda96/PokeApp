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
    
    override func prepareForReuse() {
    }
    
    func setupPokemonCell(name: String, number: Int, sprite: String, types: [String]){
        self.mainTitle.text = name
        self.secondaryTitle.text = String(format: "#%03d", number)
        self.mainType.image = UIImage(named: types[0])! //cropImage1(image: UIImage(named: types[0])!, rect: CGRect(x: 20, y: 20, width: 40.0, height: 40.0))
        if types.count > 1 {
            self.secondaryType.isHidden = false
            self.secondaryType.image = UIImage(named: types[1])! // cropImage1(image: UIImage(named: types[1])!, rect: CGRect(x: 20, y: 20, width: 40.0, height: 40.0))
        } else {
            self.secondaryType.isHidden = true
        }
        self.descriptionLabel.isHidden = true
        
//        self.mainImage.load(url: URL(string: sprite)!)
        
        
        let imgUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(String(number)).png"
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL(string: imgUrl)!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.mainImage.image =  image //self!
                    }
                }
            }
        }
        
        
        
    }
    
    func cropImage1(image: UIImage, rect: CGRect) -> UIImage {
        let cgImage = image.cgImage! // better to write "guard" in realm app
        let croppedCGImage = cgImage.cropping(to: rect)
        return UIImage(cgImage: croppedCGImage!)
    }
    
//    func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect, viewWidth: CGFloat, viewHeight: CGFloat) -> UIImage?
//    {
//        let imageViewScale = max(inputImage.size.width / viewWidth,
//                                 inputImage.size.height / viewHeight)
//
//        // Scale cropRect to handle images larger than shown-on-screen size
//        let cropZone = CGRect(x:cropRect.origin.x * imageViewScale,
//                              y:cropRect.origin.y * imageViewScale,
//                              width:cropRect.size.width * imageViewScale,
//                              height:cropRect.size.height * imageViewScale)
//
//        // Perform cropping in Core Graphics
//        guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to:cropZone)
//        else {
//            return nil
//        }
//
//        // Return image to UIImage
//        let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
//        return croppedImage
//    }
    
}

    
    
