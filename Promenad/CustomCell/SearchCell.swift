//
//  SearchCell.swift
//  Promenad
//
//  Created by LiuYan on 8/3/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    @IBOutlet weak var avatar_view: UIImageView!
    
    @IBOutlet weak var avatar_name: UILabel!
    
    @IBOutlet weak var avatar_distance: UILabel!
    override func awakeFromNib() {
        self.avatar_view.layer.cornerRadius = self.avatar_view.frame.width / 2
        self.avatar_view.layer.masksToBounds = true
    }
}
