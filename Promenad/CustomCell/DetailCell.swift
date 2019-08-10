//
//  DetailCell.swift
//  Promenad
//
//  Created by LiuYan on 8/2/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class DetailCell: UICollectionViewCell {
    
    @IBOutlet weak var user_photo: UIImageView!
    override func awakeFromNib() {
        self.user_photo.layer.cornerRadius = 5
        self.user_photo.layer.masksToBounds = true
    }
}
