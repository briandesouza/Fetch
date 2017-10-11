//
//  AddDogCell.swift
//  Fetch
//
//  Created by Pablo Garces on 10/10/17.
//  Copyright © 2017 Fetch. All rights reserved.
//

import UIKit

class AddDogCell: UITableViewCell, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIViewControllerTransitioningDelegate {
    
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
    @IBOutlet weak var dogImgBtn: UIButton!
    
    var ageNum = 1
    var index: Int = 0
    var imagePicker = UIImagePickerController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layoutMargins = .zero
        
        dogImgBack.layer.cornerRadius = 50
        dogImg.layer.cornerRadius = 46
        dogImg.layer.masksToBounds = true
        dogImg.contentMode = .scaleAspectFill
        dogImg.backgroundColor = UIColor.white
        
        addCircBack.layer.cornerRadius = 16
        addCircImg.layer.cornerRadius = 13
        addCircImg.layer.masksToBounds = true
        addCircImg.contentMode = .scaleAspectFill
        
        ageLbl.text = "\(ageNum)"
        dogImg.image = UIImage(named: "dogholder")
        
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
    
    @IBAction func dogImgBtnPressed(_ sender: Any) {
        indexPressed = index
        
        let storyboard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let signUpVC: SignUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC & UIImagePickerControllerDelegate
        
        signUpVC.abc123()
        
        print("indexPressed", indexPressed)
    }
    
    @IBAction func minusAgeBtnPressed(_ sender: Any) {
        
        if !(ageNum < 2) {
            ageNum = ageNum - 1
        }
        
        ageLbl.text = "\(ageNum)"
    }
    
}
