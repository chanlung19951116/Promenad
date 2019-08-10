//
//  InterestCell.swift
//  Promenad
//
//  Created by LiuYan on 8/1/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class InterestCell: UICollectionViewCell {
   
    @IBOutlet weak var title_lbl: UILabel!
    
    @IBOutlet weak var card_view: CardView!
    var cellindex: Int = 0
    override func awakeFromNib() {
       
    }
}
class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photo_image: UIImageView!
    
    @IBOutlet weak var photo_number: UILabel!
    
    @IBOutlet weak var delete_smallphoto: UIImageView!
    @IBOutlet weak var delete_photo: UIImageView!
    var vc: UIViewController!
    override func awakeFromNib() {
        self.photo_image.layer.cornerRadius = 5
        self.photo_image.layer.masksToBounds = true
    }
}
class AddPhotoCell: UICollectionViewCell {
    
    
    override func awakeFromNib() {
        
    }
}
class InterestProfileCell: UICollectionViewCell {
    
    @IBOutlet weak var interest_title: UILabel!
    
    override func awakeFromNib() {
        
    }
}


