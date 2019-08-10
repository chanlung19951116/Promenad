//
//  ContentCell.swift
//  Promenad
//
//  Created by LiuYan on 8/4/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class ContentCell: UITableViewCell {

    
    
    @IBOutlet weak var chat_statusImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var view_checkbox: Checkbox!
    
    @IBOutlet weak var push_checkbox: Checkbox!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let selborder_color = UIColor.init(red: 36/255, green: 189/255, blue: 88/255, alpha: 1.0)
        let selfill_color = UIColor.init(red: 65/255, green: 212/255, blue: 115/255, alpha: 1.0)
        let unsel_bordercolor = UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        let unsel_fillcolor = UIColor.init(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
       
        view_checkbox.layer.backgroundColor = unsel_fillcolor.cgColor
        view_checkbox.checkedBorderColor = selborder_color
        view_checkbox.uncheckedBorderColor = unsel_bordercolor
        view_checkbox.checkmarkColor = UIColor.white
        view_checkbox.checkmarkStyle = .tick
        view_checkbox.borderStyle = .square
        view_checkbox.addTarget(self, action: #selector(viewcheckboxValueChanged(sender:)), for: .valueChanged)
        
        
        push_checkbox.layer.backgroundColor = unsel_fillcolor.cgColor
        push_checkbox.checkedBorderColor = selborder_color
        push_checkbox.uncheckedBorderColor = unsel_bordercolor
        push_checkbox.checkmarkColor = UIColor.white
        push_checkbox.checkmarkStyle = .tick
        push_checkbox.borderStyle = .square
        push_checkbox.addTarget(self, action: #selector(pushcheckboxValueChanged(sender:)), for: .valueChanged)
        if (view_checkbox.isChecked == true){
            self.view_checkbox.checkboxFillColor = selfill_color
        }else{
            self.view_checkbox.checkboxFillColor = unsel_fillcolor
        }
        if (push_checkbox.isChecked == true){
            self.view_checkbox.checkboxFillColor = selfill_color
        }else{
            self.view_checkbox.checkboxFillColor = unsel_fillcolor
        }
    }
    @objc func viewcheckboxValueChanged(sender: Checkbox) {
        print("checkbox value change: \(sender.isChecked)")
        let selfill_color = UIColor.init(red: 65/255, green: 212/255, blue: 115/255, alpha: 1.0)
         let unsel_fillcolor = UIColor.init(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        if (sender.isChecked == true){
            self.view_checkbox.checkboxFillColor = selfill_color
        }else{
            self.view_checkbox.checkboxFillColor = unsel_fillcolor
        }
    }
    @objc func pushcheckboxValueChanged(sender: Checkbox) {
        print("checkbox value change: \(sender.isChecked)")
        let selfill_color = UIColor.init(red: 65/255, green: 212/255, blue: 115/255, alpha: 1.0)
        let unsel_fillcolor = UIColor.init(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        if (sender.isChecked == true){
            self.push_checkbox.checkboxFillColor = selfill_color
        }else{
            self.push_checkbox.checkboxFillColor = unsel_fillcolor
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
