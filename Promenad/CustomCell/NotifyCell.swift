//
//  NotifyCell.swift
//  Promenad
//
//  Created by LiuYan on 8/4/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class NotifyCell: UITableViewCell {

    
    
    @IBOutlet weak var assistant_userImage: UIImageView!
    
    @IBOutlet weak var state: UILabel!
    
    @IBOutlet weak var user_nameage: UILabel!
    
    @IBOutlet weak var time_lbl: UILabel!
    
    @IBOutlet weak var status: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.assistant_userImage.layer.cornerRadius = self.assistant_userImage.frame.width / 2
        self.assistant_userImage.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
class ItemCell: UITableViewCell {
    @IBOutlet weak var textlabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
