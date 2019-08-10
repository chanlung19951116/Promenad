//
//  UserProfileStep2.swift
//  Promenad
//
//  Created by LiuYan on 7/31/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit
import SearchTextField
class UserProfileStep2: UIViewController {

    @IBOutlet weak var city_field: SearchTextField!
    @IBOutlet weak var back_btn: UIImageView!
    @IBOutlet weak var next_view: CardView!
    
    @IBOutlet weak var city_title: UILabel!
    
    @IBOutlet weak var about_me: UITextView!
    @IBOutlet weak var city_view: CardView!
    var cities = NSMutableArray()
    var citynames: [String] = []
    var keyboardheight : CGFloat = 0
    
    @IBOutlet weak var second_height: NSLayoutConstraint!
    @IBOutlet weak var bottom_height: NSLayoutConstraint!
    var country_name: String = ""
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
                city_view.isHidden = true
                city_title.isHidden = true
                second_height.constant = 30
                if DeviceType.iPhoneX {
                    print("testtest")
                     bottom_height.constant = 20 + keyboardheight
                }else{
                     bottom_height.constant = 20 + keyboardheight
                }
                
                
                
            }
        
        
    }
    @objc func hideKeyboard(notification: Notification) {
        city_view.isHidden = false
        city_title.isHidden = false
        if DeviceType.iPhoneX {
             bottom_height.constant = 20
            
        }else {
             bottom_height.constant = 20
            
        }
          second_height.constant = 197
    }
    func initUI(){
        bottom_height.constant = 20
        second_height.constant = 197
        let country_count = AppData.shared.countries.count
        for index in 0..<country_count {
            let country = AppData.shared.countries[index] as! NSDictionary
            let country_data = country["cities"] as! NSArray
            let city_count = country_data.count
            for j in 0..<city_count {
                let city_data = country_data[j] as! NSDictionary
                let city_name = city_data["name"] as! String
                print(city_name)
                self.citynames.append(city_name)
            }
        }
        city_field.filterStrings(citynames)
        self.city_field.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            
            print("Item at position \(itemPosition): ")
            
            // Do whatever you want with the picked item
            self.city_field.text = self.citynames[itemPosition]
            let country_count = AppData.shared.countries.count
            for index in 0..<country_count {
                let country = AppData.shared.countries[index] as! NSDictionary
                let country_names = country["Code"] as! String
                let country_data = country["cities"] as! NSArray
                let city_count = country_data.count
                for j in 0..<city_count {
                    let city_data = country_data[j] as! NSDictionary
                    let city_name = city_data["name"] as! String
                    print(city_name)
                    if (self.citynames[itemPosition] == city_name){
                        self.country_name = country_names
                    }
                }
            }
            
            
        }
        let back_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Back_action))
        back_btn.addGestureRecognizer(back_gesture)
        back_btn.isUserInteractionEnabled = true
        let next_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Next_Page))
        next_view.addGestureRecognizer(next_gesture)
    }
    @objc func Back_action(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    @objc func Next_Page(){
        let city = self.city_field.text as! String
        if (city.isEmpty) {
            AppData.shared.displayToastMessage("Please input residence")
            return
        }
        let about_mestr = self.about_me.text as! String
        if (about_mestr.isEmpty){
            AppData.shared.displayToastMessage("Please input About Me.")
        }
        AppData.shared.user_city = city
        AppData.shared.user_country = self.country_name
        AppData.shared.user_about = about_mestr
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "userprofilestep3VC") as! UserProfileStep3
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
