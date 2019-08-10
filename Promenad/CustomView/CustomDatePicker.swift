//
//  CustomDatePicker.swift
//  Promenad
//
//  Created by LiuYan on 7/30/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import Foundation
import UIKit
class CustomDatePicker: UIView, ModalCustom {
    var backgroundView = UIView()
    var dialogView = UIView()
    
    var k:Float = 0
   
    var day_lbl: UILabel!
    var month_lbl: UILabel!
    var year_lbl: UILabel!
    var datePicker : UIDatePicker!
    var birthday: String = ""
    convenience init(title:String,day_lbl: UILabel,month_lbl: UILabel,year_lbl: UILabel,birthday: String){
        self.init(frame: UIScreen.main.bounds)
        initialize(title: title,day_lbl: day_lbl,month_lbl: month_lbl,year_lbl: year_lbl,birthday: birthday)
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initialize(title:String,day_lbl: UILabel,month_lbl: UILabel,year_lbl: UILabel,birthday: String){
        self.birthday = birthday
        self.day_lbl = day_lbl
        self.month_lbl = month_lbl
        self.year_lbl = year_lbl
        dialogView.clipsToBounds = true
        
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        
        let dialogViewWidth = frame.width-64
        let blueColor = UIColor(red: 44/255.0, green: 173/255.0, blue: 227/255.0, alpha: 1.0)
        let titlelabel = UILabel(frame: CGRect(x: 0, y: 0, width: dialogViewWidth, height: 33))
        titlelabel.text = "Date PickerDialog"
        titlelabel.textColor = UIColor.white
        titlelabel.textAlignment = .center
        titlelabel.font = UIFont.systemFont(ofSize: 15)
        titlelabel.layer.backgroundColor = blueColor.cgColor
        dialogView.addSubview(titlelabel)
        
        datePicker = UIDatePicker(frame: CGRect(x: 8, y: 33, width: dialogViewWidth-16, height: 180))
        datePicker.datePickerMode = .date
        dialogView.addSubview(datePicker)
        
        
        
        let center = dialogViewWidth / 2
        
        let Ok_btn = UIButton(frame: CGRect(x: center - 80, y: 233, width: 60, height: 20))
        Ok_btn.setTitle("Ok", for: .normal)
        Ok_btn.setTitleColor(UIColor.black, for: .normal)
        Ok_btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        Ok_btn.addTarget(self, action: #selector(Ok_Action), for: .touchUpInside)
        dialogView.addSubview(Ok_btn)
        
        let Cancel_btn = UIButton(frame: CGRect(x: center + 20, y: 233, width: 60, height: 20))
        Cancel_btn.setTitle("Cancel", for: .normal)
        Cancel_btn.setTitleColor(UIColor.black, for: .normal)
        Cancel_btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        Cancel_btn.addTarget(self, action: #selector(Cancel_Action), for: .touchUpInside)
        dialogView.addSubview(Cancel_btn)
        
        
        let dialogViewHeight =  CGFloat(273)
        
        dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: frame.width-64, height: dialogViewHeight)
        
        dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 6
        addSubview(dialogView)
    }
    
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: true)
    }
    
    @objc func Ok_Action(sender: UIButton!) {
        dismiss(animated: true)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: self.datePicker.date)
        let dateStringArray = dateString.components(separatedBy: "-")
        self.day_lbl.text = dateStringArray[2]
        self.month_lbl.text = dateStringArray[1]
        self.year_lbl.text = dateStringArray[0]
        self.birthday = dateString
        print(dateString)
    }
    @objc func Cancel_Action(sender: UIButton!) {
    
        dismiss(animated: true)
        
    }
}
