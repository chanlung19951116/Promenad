//
//  UserProfileStep4.swift
//  Promenad
//
//  Created by LiuYan on 8/1/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class UserProfileStep4: UIViewController {

    @IBOutlet weak var interest_view: UICollectionView!
    
    @IBOutlet weak var next_view: CardView!
    @IBOutlet weak var back_btn: UIImageView!
    
    @IBOutlet weak var view_title1: UILabel!
    @IBOutlet weak var view_title2: UILabel!
    @IBOutlet weak var view_title3: UILabel!
    
    @IBOutlet weak var bottom_height: NSLayoutConstraint!
    var keyboardheight: CGFloat = 0
    var arrayString : [String] = ["Photography","Fishing","Tennis","Adventure","Theater","Travel","Philosophy","Fitness","Food","Shopping","Fashion","Sport","Swimming","Reading","Sleep","Drawing","Cooking","Skiing"]
    var interestString:String = ""
    var selectArrayString: [String] = []
    
    @IBOutlet weak var interest_filed: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        NotificationCenter.default.addObserver(self, selector: #selector(self.showKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func showKeyboard(notification: Notification) {
        
        if let frame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let height = frame.cgRectValue.height
            self.keyboardheight = height
            self.view_title1.isHidden = true
            self.view_title2.isHidden = true
            self.view_title3.isHidden = true
            self.interest_view.isHidden = true
            if DeviceType.iPhoneX {
                print("testtest")
                bottom_height.constant = 20 + keyboardheight
            }else{
                bottom_height.constant = 20 + keyboardheight
            }
            
            
            
        }
        
        
    }
    @objc func hideKeyboard(notification: Notification) {
        self.view_title1.isHidden = false
        self.view_title2.isHidden = false
        self.view_title3.isHidden = false
        self.interest_view.isHidden = false
        if DeviceType.iPhoneX {
            bottom_height.constant = 20
            
        }else {
            bottom_height.constant = 20
            
        }
       
    }
    func initUI(){
        bottom_height.constant = 20
        interest_view.delegate = self
        interest_view.dataSource = self
        let back_gesture = UITapGestureRecognizer(target:self,action: #selector(self.Back_action))
        back_btn.addGestureRecognizer(back_gesture)
        back_btn.isUserInteractionEnabled = true
        let next_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Next_Page))
        next_view.addGestureRecognizer(next_gesture)
    }
    @objc func Next_Page(){
        
        if (self.interestString.isEmpty){
            AppData.shared.displayToastMessage("Please input interests")
            return
        }
        let interestEtc = self.interest_filed.text as! String
        AppData.shared.user_Interest = self.interestString + interestEtc
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "userprofilephotoVC") as! UserProfilePhotoVC
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func Back_action(){
        _ = self.navigationController?.popViewController(animated: true)
    }
}
extension UserProfileStep4: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayString.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interestCell", for: indexPath) as! InterestCell
        cell.title_lbl.text = arrayString[indexPath.row]
        let  bg_color = UIColor.init(red: 232/255, green: 232/255, blue: 232/255, alpha: 1.0)
        cell.card_view.layer.backgroundColor = bg_color.cgColor
        cell.cellindex = indexPath.row
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionViewCell : InterestCell = collectionView.cellForItem(at: indexPath) as! InterestCell
        let each_string = self.arrayString[indexPath.row] as! String
        print(each_string)
        if (collectionViewCell.title_lbl.textColor != UIColor.white) {
            let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
            collectionViewCell.card_view.layer.backgroundColor = bgselect_color.cgColor
            collectionViewCell.title_lbl.textColor = UIColor.white
            
        }else{
            let  bg_color = UIColor.init(red: 232/255, green: 232/255, blue: 232/255, alpha: 1.0)
            collectionViewCell.card_view.layer.backgroundColor = bg_color.cgColor
            let text_color = UIColor.init(red: 70/255, green: 69/255, blue: 77/255, alpha: 1.0)
            collectionViewCell.title_lbl.textColor = text_color
            
            
        }
        print(self.selectArrayString.count)
        var flag: Int = 0
        var position: Int = 0
        for index_arr in 0..<self.selectArrayString.count {
            let each_subString = self.selectArrayString[index_arr] as! String
            if (each_subString == each_string){
                position = index_arr
                flag = 1
            }
            print(each_subString)
        }
        if (flag == 0){
            self.selectArrayString.append(each_string)
        }
        if (flag == 1){
            self.selectArrayString.remove(at: position)
        }

        self.interestString = ""
        if (self.selectArrayString.count > 0){
            if (self.selectArrayString.count == 1){
                self.interestString = self.selectArrayString[0]
            }else {
                for index_sub in 0..<self.selectArrayString.count {
                    let add_str = self.selectArrayString[index_sub] as! String
                    if (index_sub < self.selectArrayString.count - 1){
                        self.interestString = self.interestString + add_str + ","
                    }else{
                        self.interestString = self.interestString + add_str
                    }
                }
            }

        }
        //self.interest_filed.text = self.interestString
        
    }
    
    
}

extension UserProfileStep4: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        return CGSize(width: (bounds.width - 25) / 3, height: (bounds.height - 50 ) / 6)
    }
}

