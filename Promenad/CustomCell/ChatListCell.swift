//
//  ChatListCell.swift
//  Promenad
//
//  Created by LiuYan on 8/1/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class ChatListCell: UITableViewCell {

    
    
    @IBOutlet weak var user_profileImage: UIImageView!
    @IBOutlet weak var user_name: UILabel!
    
    @IBOutlet weak var user_onlinestatus: UIImageView!
    
    @IBOutlet weak var user_lastmessage: UILabel!
    
    @IBOutlet weak var user_chattime: UILabel!
    
    @IBOutlet weak var user_chatsave: UIImageView!
    @IBOutlet weak var user_chattype: UIImageView!
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
