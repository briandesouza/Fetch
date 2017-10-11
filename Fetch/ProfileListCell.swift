//
//  ProfileListCell.swift
//  Fetch
//
//  Created by Pablo Garces on 10/11/17.
//  Copyright © 2017 Fetch. All rights reserved.
//

import UIKit

class ProfileListCell: UITableViewCell {
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        img1.layer.masksToBounds = true
        img2.layer.masksToBounds = true
        img3.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
