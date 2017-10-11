//
//  AddRowCell.swift
//  Fetch
//
//  Created by Pablo Garces on 10/10/17.
//  Copyright © 2017 Fetch. All rights reserved.
//

import UIKit

class AddRowCell: UITableViewCell {
    
    @IBOutlet weak var addImg: UIImageView!
    @IBOutlet weak var addDogBtn: UIButton!
    
    weak var delegate: AddRowDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addImg.layer.cornerRadius = 20
        addImg.layer.masksToBounds = true
        
        //addDogBtn.addTarget(self, action: #selector(SignUpVC.addRowBtnTapped), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addRowBtnPressed(_ sender: Any) {
        delegate?.addRowBtnTapped()
    }
}

protocol AddRowDelegate: class {
    func addRowBtnTapped()
}
