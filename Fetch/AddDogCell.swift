//
//  AddDogCell.swift
//  Fetch
//
//  Created by Pablo Garces on 10/10/17.
//  Copyright © 2017 Fetch. All rights reserved.
//

import UIKit

class AddDogCell: UITableViewCell {
    
    @IBOutlet weak var dogImgBack: UIView!
    @IBOutlet weak var dogImg: UIImageView!
    @IBOutlet weak var addCircBack: UIView!
    @IBOutlet weak var addCircImg: UIImageView!
    @IBOutlet weak var plusAgeBtn: UIButton!
    @IBOutlet weak var minusAgeBtn: UIButton!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var dogNameField: AnimatedTextField!
    @IBOutlet weak var dogBreedField: AnimatedTextField!
    @IBOutlet weak var cellNumberLbl: UILabel!
    
    var ageNum = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layoutMargins = .zero
        
        dogImgBack.layer.cornerRadius = 50
        dogImg.layer.cornerRadius = 46
        dogImg.layer.masksToBounds = true
        dogImg.contentMode = .scaleAspectFill
        
        addCircBack.layer.cornerRadius = 16
        addCircImg.layer.cornerRadius = 13
        addCircImg.layer.masksToBounds = true
        addCircImg.contentMode = .scaleAspectFill
        
        ageLbl.text = "\(ageNum)"
        dogImg.image = UIImage(named: "personplaceholder")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func plusAgeBtnPressed(_ sender: Any) {
        
        if !(ageNum > 19) {
            ageNum = ageNum + 1
        }
        
        ageLbl.text = "\(ageNum)"
    }
    
    @IBAction func minusAgeBtnPressed(_ sender: Any) {
        
        if !(ageNum < 2) {
            ageNum = ageNum - 1
        }
        
        ageLbl.text = "\(ageNum)"
    }
    
}
