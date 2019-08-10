//
//  FilterDialog.swift
//  Promenad
//
//  Created by LiuYan on 8/3/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import Foundation
import UIKit
import WARangeSlider
class FilterDialog: UIView, FilterModal {
    var backgroundView = UIView()
    var dialogView = UIView()
    
    var k:Float = 0
    
    var lowerlabel: UILabel!
    var lowerlabelheight: CGFloat!
    var upperlabel: UILabel!
    var range_width: CGFloat!
    var lower_ypos: CGFloat!
    var vc: UIViewController!
    var  popular: UILabel!
    var nearby: UILabel!
    var subscriblelbl: UILabel!
    var sortType: String = ""
    var search_loveimage: UIImageView!
    var search_chatimage: UIImageView!
    var search_seximage: UIImageView!
    var search_smileimage: UIImageView!
    var search_planeimage: UIImageView!
    var purposeString : String = ""
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
        let dialogViewHeight =  frame.height - 135
        
        let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        let text_color = UIColor.init(red: 70/255, green: 69/255, blue: 77/255, alpha: 1.0)
        let bg_color = UIColor.init(red: 232/255, green: 232/255, blue: 232/255, alpha: 1.0)
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 20, width: dialogViewWidth / 4, height: dialogViewHeight / 30 ))
        titleLabel.text = "Filter"
        titleLabel.textColor = bgselect_color
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        dialogView.addSubview(titleLabel)
        
        let close = UIImageView(frame: CGRect(x: dialogViewWidth - 40, y: 20, width: 20 ,height: dialogViewHeight / 30 ))
        let closeimage = UIImage(named: "close_btn")!
        close.image = closeimage
        close.contentMode = . scaleAspectFit
        let close_gesture = UITapGestureRecognizer(target:self,action:#selector(self.didTappedOnBackgroundView))
        close.addGestureRecognizer(close_gesture)
        close.isUserInteractionEnabled = true
        dialogView.addSubview(close)
        
        let linelabel = UILabel(frame: CGRect(x: 0, y: 20 + dialogViewHeight / 15, width: dialogViewWidth, height: 0.05))
        linelabel.layer.backgroundColor = UIColor.lightGray.cgColor
        dialogView.addSubview(linelabel)
        
        let sortlabel = UILabel(frame: CGRect(x: 0, y: 40 + dialogViewHeight / 15 , width: dialogViewWidth, height: dialogViewHeight / 30))
        sortlabel.text = "Sort by"
        sortlabel.textAlignment = .center
        sortlabel.textColor = text_color
        dialogView.addSubview(sortlabel)
        
        let cardView = CardView(frame: CGRect(x: 20, y: 40 + dialogViewHeight / 15 + dialogViewHeight / 15, width: dialogViewWidth - 40, height: dialogViewHeight / 15))
        let label_width = (dialogViewWidth - 40) / 3
        
        popular = UILabel(frame: CGRect(x: 0, y: 0, width: label_width, height: dialogViewHeight / 15))
        popular.textAlignment = .center
        popular.text = "Popular"
        popular.font = UIFont.boldSystemFont(ofSize: 12)
        let popular_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Select_Pop))
        popular.addGestureRecognizer(popular_gesture)
        popular.isUserInteractionEnabled = true
        popular.textColor = text_color
        
        cardView.addSubview(popular)
        
        let divlable1 = UILabel(frame: CGRect(x: label_width, y: dialogViewHeight / 45, width: 1, height: dialogViewHeight / 45))
        divlable1.layer.backgroundColor = UIColor.lightGray.cgColor
        cardView.addSubview(divlable1)
        
        nearby = UILabel(frame: CGRect(x: label_width + 1, y: 0, width: label_width, height: dialogViewHeight / 15))
        nearby.textAlignment = .center
        nearby.text = "Nearby"
        nearby.textColor = text_color
        nearby.font = UIFont.boldSystemFont(ofSize: 12)
        let near_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Select_Near))
        nearby.addGestureRecognizer(near_gesture)
        nearby.isUserInteractionEnabled = true
        cardView.addSubview(nearby)
        
        let divlable2 = UILabel(frame: CGRect(x: label_width + label_width, y: dialogViewHeight / 45, width: 1, height: dialogViewHeight / 45))
        divlable2.layer.backgroundColor = UIColor.lightGray.cgColor
        cardView.addSubview(divlable2)
        
        subscriblelbl = UILabel(frame: CGRect(x: label_width + label_width, y: 0, width: label_width, height: dialogViewHeight / 15))
        subscriblelbl.textAlignment = .center
        subscriblelbl.text = "Sub"
        subscriblelbl.font = UIFont.boldSystemFont(ofSize: 12)
        subscriblelbl.textColor = text_color
        let sub_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Select_Sub))
        subscriblelbl.addGestureRecognizer(sub_gesture)
        subscriblelbl.isUserInteractionEnabled = true
        cardView.addSubview(subscriblelbl)
        
        cardView.layer.backgroundColor = bg_color.cgColor
        dialogView.addSubview(cardView)
        
        let purposeLabel = UILabel(frame: CGRect(x: 0, y: 60 + dialogViewHeight / 5 , width: dialogViewWidth, height: dialogViewHeight / 30))
        purposeLabel.textAlignment = .center
        purposeLabel.textColor = text_color
        purposeLabel.text = "Purpose of Dating"
        dialogView.addSubview(purposeLabel)
        
        let card_width = (dialogViewWidth - 60) / 5
        let cardView1 = CardView(frame: CGRect(x: 20, y: 80 + dialogViewHeight / 5 + dialogViewHeight / 30, width: card_width, height: card_width))
        let image1 = UIImage(named: "ic_love")!
        search_loveimage = UIImageView(frame: CGRect(x: card_width / 2 - 10, y: card_width / 2 - 10, width: 20, height: 20))
        search_loveimage.image = UIImage(named: "search_unlove")
        search_loveimage.contentMode = .scaleAspectFit
        cardView1.addSubview(search_loveimage)
        cardView1.layer.backgroundColor = bg_color.cgColor
        dialogView.addSubview(cardView1)
        
        let cardView2 = CardView(frame: CGRect(x: 20 + card_width + 5, y: 80 + dialogViewHeight / 5 + dialogViewHeight / 30, width: card_width, height: card_width))
        let image2 = UIImage(named: "chat")!
        search_chatimage = UIImageView(frame: CGRect(x: card_width / 2 - 10, y: card_width / 2 - 10, width: 20, height: 20))
        search_chatimage.image =  UIImage(named: "search_unchat")
        search_chatimage.contentMode = .scaleAspectFit
        cardView2.addSubview(search_chatimage)
        cardView2.layer.backgroundColor = bg_color.cgColor
        dialogView.addSubview(cardView2)
        
        let cardView3 = CardView(frame: CGRect(x: 20 + card_width + 10 + card_width, y: 80 + dialogViewHeight / 5 + dialogViewHeight / 30, width: card_width, height: card_width))
       
        search_seximage = UIImageView(frame: CGRect(x: card_width / 2 - 10, y: card_width / 2 - 10, width: 20, height: 20))
        search_seximage.image = UIImage(named: "search_unsex")
        search_seximage.contentMode = .scaleAspectFit
        cardView3.addSubview(search_seximage)
        cardView3.layer.backgroundColor = bg_color.cgColor
        dialogView.addSubview(cardView3)
        
        let cardView4 = CardView(frame: CGRect(x: 20 + 3 * card_width + 15, y: 80 + dialogViewHeight / 5 + dialogViewHeight / 30, width: card_width, height: card_width))
       
        search_smileimage = UIImageView(frame: CGRect(x: card_width / 2 - 10, y: card_width / 2 - 10, width: 20, height: 20))
        search_smileimage.image = UIImage(named: "search_unsmile")
        search_smileimage.contentMode = .scaleAspectFit
        cardView4.addSubview(search_smileimage)
        cardView4.layer.backgroundColor = bg_color.cgColor
        dialogView.addSubview(cardView4)
        
        let cardView5 = CardView(frame: CGRect(x: 20 + 4 * card_width + 20, y: 80 + dialogViewHeight / 5 + dialogViewHeight / 30, width: card_width, height: card_width))
      
        search_planeimage = UIImageView(frame: CGRect(x: card_width / 2 - 10, y: card_width / 2 - 10, width: 20, height: 20))
        search_planeimage.image = UIImage(named: "search_unplane")
        cardView5.addSubview(search_planeimage)
        cardView5.contentMode = .scaleAspectFit
        cardView5.layer.backgroundColor = bg_color.cgColor
        dialogView.addSubview(cardView5)
        let purpose_lovegesture = UITapGestureRecognizer(target:self,action:#selector(self.purpose_of_love))
        let purpose_chatgesture = UITapGestureRecognizer(target:self,action:#selector(self.purpose_of_chat))
        let purpose_sexgesture = UITapGestureRecognizer(target:self,action:#selector(self.purpose_of_sex))
        let purpose_smilegesture = UITapGestureRecognizer(target:self,action:#selector(self.purpose_of_smile))
        let purpose_planegesture = UITapGestureRecognizer(target:self,action:#selector(self.purpose_of_plane))
        cardView1.addGestureRecognizer(purpose_lovegesture)
        cardView2.addGestureRecognizer(purpose_chatgesture)
        cardView3.addGestureRecognizer(purpose_sexgesture)
        cardView4.addGestureRecognizer(purpose_smilegesture)
        cardView5.addGestureRecognizer(purpose_planegesture)
        let agelabel = UILabel(frame: CGRect(x: 0, y: 110 + dialogViewHeight / 5 + dialogViewHeight / 30 + card_width , width: dialogViewWidth, height: dialogViewHeight / 30))
        agelabel.textAlignment = .center
        agelabel.textColor = text_color
        agelabel.text = "Age range"
        dialogView.addSubview(agelabel)
       
        range_width = dialogViewWidth - 40
        lowerlabelheight = dialogViewHeight / 30
        lower_ypos = 160 + dialogViewHeight / 5 + dialogViewHeight / 30  + card_width
        let lower_x = (26 * range_width) / 100
        let upper_x = (34 * range_width) / 100
        lowerlabel = UILabel(frame: CGRect(x: 15 + lower_x, y: 160 + dialogViewHeight / 5 + dialogViewHeight / 30  + card_width, width: 30, height: dialogViewHeight / 30))
        lowerlabel.text = "26"
        lowerlabel.font = UIFont.systemFont(ofSize: 12)
        lowerlabel.textAlignment = .left
        lowerlabel.textColor = text_color
        dialogView.addSubview(lowerlabel)
        
        upperlabel = UILabel(frame: CGRect(x: 15 + upper_x, y: 160 + dialogViewHeight / 5 + dialogViewHeight / 30  + card_width, width: 30, height: dialogViewHeight / 30))
        upperlabel.text = "34"
        upperlabel.font = UIFont.systemFont(ofSize: 12)
        upperlabel.textAlignment = .left
        upperlabel.textColor = text_color
        dialogView.addSubview(upperlabel)
        
        let rangeSlider = RangeSlider(frame: CGRect(x: 20, y: 180 + dialogViewHeight / 5 + dialogViewHeight / 30  + card_width, width: dialogViewWidth - 40, height: dialogViewHeight / 30))
        rangeSlider.minimumValue = 0
        rangeSlider.maximumValue = 100
        rangeSlider.lowerValue = 26
        rangeSlider.upperValue = 34
        rangeSlider.trackTintColor = UIColor.lightGray
        rangeSlider.trackHighlightTintColor = bgselect_color
        rangeSlider.thumbTintColor = UIColor.white
        rangeSlider.thumbBorderColor = bgselect_color
        rangeSlider.thumbBorderWidth = 2
        rangeSlider.curvaceousness = 1.0
        rangeSlider.addTarget(self, action: #selector(self.rangeSliderValueChanged(_:)), for: .valueChanged)
        dialogView.addSubview(rangeSlider)
        
        let find_btn = CardView(frame: CGRect(x: 20, y: 240 + dialogViewHeight / 5 + dialogViewHeight / 15  + card_width, width: dialogViewWidth - 40, height: card_width))
        let findbtn_lbl = UILabel(frame: CGRect(x: card_width / 2, y: card_width / 4, width: dialogViewWidth - 40 - card_width, height: card_width / 2))
        findbtn_lbl.textAlignment = .center
        findbtn_lbl.text = "FIND PEOPLE"
        findbtn_lbl.font = UIFont.boldSystemFont(ofSize: 15)
        findbtn_lbl.textColor = bgselect_color
        find_btn.addSubview(findbtn_lbl)
        find_btn.layer.backgroundColor = bg_color.cgColor
        let find_gesture = UITapGestureRecognizer(target:self,action:#selector(self.FindPeople))
        find_btn.addGestureRecognizer(find_gesture)
        dialogView.addSubview(find_btn)
        
       
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
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        
        print("Range slider value changed: (\(rangeSlider.lowerValue) , \(rangeSlider.upperValue))")
        let lowervalue = rangeSlider.lowerValue
        let lower_x = CGFloat(lowervalue) as! CGFloat
        let uppervalue = rangeSlider.upperValue
        let upper_x = CGFloat(uppervalue) as! CGFloat
        let lower_xpos = range_width * lower_x / 100
        let upper_xpos = range_width * upper_x / 100
        let lower_string = String(Int(lowervalue)) as! String
        let upper_string = String(Int(uppervalue)) as! String
        lowerlabel.text = lower_string
        upperlabel.text = upper_string
        lowerlabel.frame = CGRect(x: 15 + lower_xpos, y: lower_ypos, width: 30, height: lowerlabelheight)
        upperlabel.frame = CGRect(x: 15 + upper_xpos, y: lower_ypos, width: 30, height: lowerlabelheight)
    }
    @objc func FindPeople(){
         dismiss(animated: true)
        if (self.sortType == "NearBy"){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "searchVC") as! SearchVC
            // self.present(verificationController, animated: true, completion: nil)
            self.vc.navigationController?.pushViewController(vc, animated: true)
        }else{
            let lower_age = self.lowerlabel.text as! String
            let upper_age = self.upperlabel.text as! String
            let age_str = lower_age + "," + upper_age
            
            self.PopularSearch(age: age_str, purpose: self.purposeString)
            
        }
    }
    @objc func Select_Pop(){
        self.sortType = "Popular"
        let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        let text_color = UIColor.init(red: 70/255, green: 69/255, blue: 77/255, alpha: 1.0)
        self.popular.textColor = bgselect_color
        self.nearby.textColor = text_color
        self.subscriblelbl.textColor = text_color
    }
    @objc func Select_Near(){
        self.sortType = "NearBy"
        let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        let text_color = UIColor.init(red: 70/255, green: 69/255, blue: 77/255, alpha: 1.0)
        self.popular.textColor = text_color
        self.nearby.textColor = bgselect_color
        self.subscriblelbl.textColor = text_color
    }
    @objc func Select_Sub(){
        self.sortType = "Sub"
        let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        let text_color = UIColor.init(red: 70/255, green: 69/255, blue: 77/255, alpha: 1.0)
        self.popular.textColor = text_color
        self.nearby.textColor = text_color
        self.subscriblelbl.textColor = bgselect_color
    }
    func PopularSearch(age: String , purpose:String){
        AppData.shared.showLoadingIndicator(view: self.vc.view)
        UserLocationService().NearByUsers(age: "", purpose: ""){ (response) in
            if let json = response {
                AppData.shared.hideLoadingIndicator()
                do {
                    let NearUsers = json as! NSArray
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "popularVC") as! PopularSearchVC
                    // self.present(verificationController, animated: true, completion: nil)
                    vc.UsersData = NearUsers
                    self.vc.navigationController?.pushViewController(vc, animated: true)
                }catch(let error){
                    
                }
            }else {
                AppData.shared.hideLoadingIndicator()
            }
        }
        
    }
    @objc func purpose_of_love(){
        self.search_loveimage.image = UIImage(named: "search_love")
        self.search_chatimage.image = UIImage(named: "search_unchat")
        self.search_seximage.image = UIImage(named: "search_unsex")
        self.search_smileimage.image = UIImage(named: "search_unsmile")
        self.search_planeimage.image = UIImage(named: "search_unplane")
        self.purposeString = "Serious relationship"
    }
    @objc func purpose_of_chat(){
        self.search_loveimage.image = UIImage(named: "search_unlove")
        self.search_chatimage.image = UIImage(named: "search_chat")
        self.search_seximage.image = UIImage(named: "search_unsex")
        self.search_smileimage.image = UIImage(named: "search_unsmile")
        self.search_planeimage.image = UIImage(named: "search_unplane")
        self.purposeString = "Friendship"
    }
    @objc func purpose_of_sex(){
        self.search_loveimage.image = UIImage(named: "search_unlove")
        self.search_chatimage.image = UIImage(named: "search_unchat")
        self.search_seximage.image = UIImage(named: "search_sex")
        self.search_smileimage.image = UIImage(named: "search_unsmile")
        self.search_planeimage.image = UIImage(named: "search_unplane")
        self.purposeString = "Sex"
    }
    @objc func purpose_of_smile(){
        self.search_loveimage.image = UIImage(named: "search_unlove")
        self.search_chatimage.image = UIImage(named: "search_unchat")
        self.search_seximage.image = UIImage(named: "search_unsex")
        self.search_smileimage.image = UIImage(named: "search_smile")
        self.search_planeimage.image = UIImage(named: "search_unplane")
        self.purposeString = "Flirt"
    }
    @objc func purpose_of_plane(){
        self.search_loveimage.image = UIImage(named: "search_unlove")
        self.search_chatimage.image = UIImage(named: "search_unchat")
        self.search_seximage.image = UIImage(named: "search_unsex")
        self.search_smileimage.image = UIImage(named: "search_unsmile")
        self.search_planeimage.image = UIImage(named: "search_plane")
        self.purposeString = "Travels"
    }
}
