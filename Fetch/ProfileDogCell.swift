//
//  ProfileDogCell.swift
//  Fetch
//
//  Created by Pablo Garces on 10/11/17.
//  Copyright © 2017 Fetch. All rights reserved.
//

import UIKit

class ProfileDogCell: UICollectionViewCell {
    
    @IBOutlet weak var dogImg: UIImageView!
    @IBOutlet weak var dogImgOverlay: UIView!
    @IBOutlet weak var dogBreed: UILabel!
    
    override func awakeFromNib() {
        dogImg.layer.cornerRadius = 6
        dogImg.layer.masksToBounds = true
        dogImgOverlay.layer.cornerRadius = 6
        dogImgOverlay.layer.masksToBounds = true
        
        dogBreed.textColor = UIColor.white
        dogImgOverlay.backgroundColor = UIColor(displayP3Red: 84/255, green: 157/255, blue: 214/255, alpha: 0.5)
    }
}
