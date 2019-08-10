//
//  LeafDialog.swift
//  Promenad
//
//  Created by LiuYan on 8/4/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import Foundation
import UIKit
import WARangeSlider
class LeafDialog: UIView, ModalCustom {
    var backgroundView = UIView()
    var dialogView = UIView()
    
    var k:Float = 0
    
    var vc:UIViewController!
    convenience init(title:String,vc: UIViewController){
        self.init(frame: UIScreen.main.bounds)
        initialize(title: title,vc: vc)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialize(title:String,vc: UIViewController){
        self.vc = vc
        dialogView.clipsToBounds = true
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        let dialogViewWidth = frame.width - 40
        let dialogViewHeight =  frame.height - 100
        
        let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        let text_color = UIColor.init(red: 70/255, green: 69/255, blue: 77/255, alpha: 1.0)
        let bg_color = UIColor.init(red: 232/255, green: 232/255, blue: 232/255, alpha: 1.0)
        let yellow_color = UIColor.init(red: 255/255, green: 176/255, blue: 23/255, alpha: 1.0)
        let green_color = UIColor.init(red: 65/255, green: 212/255, blue: 115/255, alpha: 1.0)
        let leaf_bg = UIImage(named: "leaf_bg")!
       
        let close = UIImageView(frame: CGRect(x: dialogViewWidth - 40, y: 20, width: 20 ,height: dialogViewHeight / 30 ))
        let closeimage = UIImage(named: "close_btn")!
        close.image = closeimage
        close.contentMode = . scaleAspectFit
        let close_gesture = UITapGestureRecognizer(target:self,action:#selector(self.didTappedOnBackgroundView))
        close.addGestureRecognizer(close_gesture)
        close.isUserInteractionEnabled = true
        dialogView.addSubview(close)
        
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 20 + dialogViewHeight / 15, width: dialogViewWidth - 40, height: 30 ))
        titleLabel.text = "Leaves packages"
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        dialogView.addSubview(titleLabel)
        
        let subtitleLabel = UILabel(frame: CGRect(x: 20, y: 40 + dialogViewHeight / 10, width: dialogViewWidth - 40, height: dialogViewHeight / 15))
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = text_color
        subtitleLabel.text = "One like cost you 6 leaves. Wait 8 hours\nfor extra leaves or by a package:"
        subtitleLabel.numberOfLines = 2
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        dialogView.addSubview(subtitleLabel)
        
        let cardView1 = CardView(frame: CGRect(x: 20, y: 70 + dialogViewHeight / 6, width: dialogViewWidth - 40, height: dialogViewHeight / 5))
        
        let card1_label = UILabel(frame: CGRect(x: 20, y: 20, width: (dialogViewWidth - 40) / 3, height: 30))
        card1_label.text = "Package S"
        card1_label.textColor = text_color
        cardView1.addSubview(card1_label)
        
        let view1 = UIView(frame: CGRect(x:20 + dialogViewWidth - (dialogViewWidth - 40) / 3 - 80, y: 20, width: (dialogViewWidth - 40) / 3, height: 30))
        view1.layer.cornerRadius = 5
        view1.layer.masksToBounds = true
        
        let view1_label = UILabel(frame: CGRect(x: 5, y: 5, width: (dialogViewWidth - 40) / 3 - 10, height: 20))
        view1_label.textAlignment = .center
        view1_label.textColor = UIColor.white
        view1_label.text = "Good one"
        view1_label.font = UIFont.systemFont(ofSize: 13)
        view1.addSubview(view1_label)
        
        view1.layer.backgroundColor = yellow_color.cgColor
        cardView1.addSubview(view1)
        
        let card1_label1 = UILabel(frame: CGRect(x: 40, y: 65, width: (dialogViewWidth - 40) / 5, height: 30))
        card1_label1.text = "100"
        card1_label1.textColor = bgselect_color
        card1_label1.font = UIFont.boldSystemFont(ofSize: 24)
        cardView1.addSubview(card1_label1)
        
        let leafimage = UIImageView(frame: CGRect(x: 20, y: 60, width: 40, height: 40))
        leafimage.image = leaf_bg
        cardView1.addSubview(leafimage)
        
        let view2 = CardView(frame: CGRect(x: 20 + dialogViewWidth - (dialogViewWidth - 40) / 3 - 80, y: 60, width: (dialogViewWidth - 40) / 3, height: 40))
        
        let view2_label = UILabel(frame: CGRect(x: 5, y: 5, width: (dialogViewWidth - 40) / 3 - 10, height: 30))
        view2_label.textColor = bgselect_color
        view2_label.text = "BUY 5$"
        view2_label.textAlignment = .center
        view2_label.font = UIFont.boldSystemFont(ofSize: 15)
        
        view2.addSubview(view2_label)
        
        view2.layer.backgroundColor = bg_color.cgColor
        cardView1.addSubview(view2)
        
        
        cardView1.layer.backgroundColor = bg_color.cgColor
        dialogView.addSubview(cardView1)
        
        let cardView2 = CardView(frame: CGRect(x: 20, y: 90 + dialogViewHeight / 6 + dialogViewHeight / 5, width: dialogViewWidth - 40, height: dialogViewHeight / 5))
        let card2_label = UILabel(frame: CGRect(x: 20, y: 20, width: (dialogViewWidth - 40) / 3, height: 30))
        card2_label.text = "Package M"
        card2_label.textColor = text_color
        cardView2.addSubview(card2_label)
        
        let card2_view2 = UIView(frame: CGRect(x:20 + dialogViewWidth - (dialogViewWidth - 40) / 3 - 80, y: 20, width: (dialogViewWidth - 40) / 3, height: 30))
        card2_view2.layer.cornerRadius = 5
        card2_view2.layer.masksToBounds = true
        let card2_view2_label = UILabel(frame: CGRect(x: 5, y: 5, width: (dialogViewWidth - 40) / 3 - 10, height: 20))
        card2_view2_label.textAlignment = .center
        card2_view2_label.textColor = UIColor.white
        card2_view2_label.text = "Save 15%"
        card2_view2_label.font = UIFont.systemFont(ofSize: 13)
        card2_view2.addSubview(card2_view2_label)
        
        card2_view2.layer.backgroundColor = green_color.cgColor
        cardView2.addSubview(card2_view2)
        
        let card2_label1 = UILabel(frame: CGRect(x: 40, y: 65, width: (dialogViewWidth - 40) / 5, height: 30))
        card2_label1.text = "500"
        card2_label1.textColor = bgselect_color
        card2_label1.font = UIFont.boldSystemFont(ofSize: 24)
        cardView2.addSubview(card2_label1)
        
        let leafimage2 = UIImageView(frame: CGRect(x: 20, y: 60, width: 40, height: 40))
        leafimage2.image = leaf_bg
        cardView2.addSubview(leafimage2)
        
        let view4 = CardView(frame: CGRect(x: 20 + dialogViewWidth - (dialogViewWidth - 40) / 3 - 80, y: 60, width: (dialogViewWidth - 40) / 3, height: 40))
        
        let view4_label = UILabel(frame: CGRect(x: 5, y: 5, width: (dialogViewWidth - 40) / 3 - 10, height: 30))
        view4_label.textColor = bgselect_color
        view4_label.text = "BUY 15$"
        view4_label.textAlignment = .center
        view4_label.font = UIFont.boldSystemFont(ofSize: 15)
        
        view4.addSubview(view4_label)
        
        view4.layer.backgroundColor = bg_color.cgColor
        cardView2.addSubview(view4)
        
        cardView2.layer.backgroundColor = bg_color.cgColor
        dialogView.addSubview(cardView2)
        
        let cardView3 = CardView(frame: CGRect(x: 20, y: 110 + dialogViewHeight / 6 + dialogViewHeight / 5 + dialogViewHeight / 5, width: dialogViewWidth - 40, height: dialogViewHeight / 5))
        let card3_label = UILabel(frame: CGRect(x: 20, y: 20, width: (dialogViewWidth - 40) / 3, height: 30))
        card3_label.text = "Package L"
        card3_label.textColor = text_color
        cardView3.addSubview(card3_label)
        
        let view3 = UIView(frame: CGRect(x:20 + dialogViewWidth - (dialogViewWidth - 40) / 3 - 80, y: 20, width: (dialogViewWidth - 40) / 3, height: 30))
        view3.layer.cornerRadius = 5
        view3.layer.masksToBounds = true
        let view3_label = UILabel(frame: CGRect(x: 5, y: 5, width: (dialogViewWidth - 40) / 3 - 10, height: 20))
        view3_label.textAlignment = .center
        view3_label.textColor = UIColor.white
        view3_label.text = "Save 30%"
        view3_label.font = UIFont.systemFont(ofSize: 13)
        view3.addSubview(view3_label)
        view3.layer.backgroundColor = green_color.cgColor
        cardView3.addSubview(view3)
        
        let card3_label1 = UILabel(frame: CGRect(x: 40, y: 65, width: (dialogViewWidth - 40) / 5, height: 30))
        card3_label1.text = "1500"
        card3_label1.textColor = bgselect_color
        card3_label1.font = UIFont.boldSystemFont(ofSize: 24)
        cardView3.addSubview(card3_label1)
        
        let leafimage3 = UIImageView(frame: CGRect(x: 20, y: 60, width: 40, height: 40))
        leafimage3.image = leaf_bg
        cardView3.addSubview(leafimage3)
        
        
        let view5 = CardView(frame: CGRect(x: 20 + dialogViewWidth - (dialogViewWidth - 40) / 3 - 80, y: 60, width: (dialogViewWidth - 40) / 3, height: 40))
        
        let view5_label = UILabel(frame: CGRect(x: 5, y: 5, width: (dialogViewWidth - 40) / 3 - 10, height: 30))
        view5_label.textColor = bgselect_color
        view5_label.text = "BUY 22$"
        view5_label.textAlignment = .center
        view5_label.font = UIFont.boldSystemFont(ofSize: 15)
        
        view5.addSubview(view5_label)
        
        view5.layer.backgroundColor = bg_color.cgColor
        cardView3.addSubview(view5)
        
        cardView3.layer.backgroundColor = bg_color.cgColor
        dialogView.addSubview(cardView3)
        
        dialogView.frame =  CGRect(x: 20, y: 160, width: dialogViewWidth, height: dialogViewHeight)
        
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 6
        addSubview(dialogView)
    }
    
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
    
    @objc func Ok_Action(sender: UIButton!) {
        
    }
    @objc func Cancel_Action(sender: UIButton!) {
        
    }
   
}
