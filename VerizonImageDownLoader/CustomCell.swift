//
//  CustomCell.swift
//  VerizonImageDownLoader
//
//  Created by Dhara Naik on 1/10/17.
//  Copyright © 2017 Verizon. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var imgThumnailImage: UIImageView!
    @IBOutlet weak var lblImageText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgThumnailImage.layer.masksToBounds = true
        //imgThumnailImage.layer.borderColor = UIColor(red:0.03, green:0.73, blue:0.85, alpha:1.0).cgColor
        imgThumnailImage.layer.borderWidth = 1.0
        imgThumnailImage.layer.cornerRadius = 5.0
        imgThumnailImage.clipsToBounds = true
        imgThumnailImage.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
