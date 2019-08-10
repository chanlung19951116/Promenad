//
//  UserlistCell.swift
//  Promenad
//
//  Created by LiuYan on 8/7/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class UserlistCell: UITableViewCell {

    
    
    @IBOutlet weak var user_profileImage: UIImageView!
    
    @IBOutlet weak var user_Namelbl: UILabel!
    
    @IBOutlet weak var online_imageView: UIImageView!
  
    @IBOutlet weak var unblock_user: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.user_profileImage.layer.cornerRadius = self.user_profileImage.frame.width / 2
        self.user_profileImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
