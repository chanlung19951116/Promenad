//
//  SenderCell.swift
//  Promenad
//
//  Created by LiuYan on 8/10/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class SenderCell: UITableViewCell {

    
    @IBOutlet weak var MessageBackground: UIImageView!
    
    @IBOutlet weak var time_label: UILabel!
    @IBOutlet weak var messageView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
