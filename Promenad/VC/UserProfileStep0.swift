//
//  UserProfileStep0.swift
//  Promenad
//
//  Created by LiuYan on 7/30/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit
import FlagPhoneNumber
class UserProfileStep0: UIViewController{
    @IBOutlet weak var mailphone_title: UILabel!
    @IBOutlet weak var next_view: CardView!
    @IBOutlet weak var next_btn: UILabel!
    @IBOutlet weak var mailphone_container: CardView!
    
    @IBOutlet weak var name_view: CardView!
    @IBOutlet weak var userName_filed: UITextField!
    
    @IBOutlet weak var birth_day: UILabel!
    
    @IBOutlet weak var birth_year: UILabel!
    @IBOutlet weak var birth_month: UILabel!
    var email_filed: UITextField!
    var phonenumberTextfiled: FPNTextField!
    
    @IBOutlet weak var day_view: CardView!
    @IBOutlet weak var month_view: CardView!
    @IBOutlet weak var year_view: CardView!
    
    
    @IBOutlet weak var center_height: NSLayoutConstraint!
    @IBOutlet weak var name_title: UILabel!
    
    @IBOutlet weak var birthday_title: UILabel!
    @IBOutlet weak var bottom_height: NSLayoutConstraint!
    var keyboardheight : CGFloat = 0
    var keyboardFlag : Int = 0
    var user_birthday : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        NotificationCenter.default.addObserver(self, selector: #selector(self.showKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func showKeyboard(notification: Notification) {
        if (userName_filed.isEditing) {
            self.name_view.isHidden = false
            self.userName_filed.isHidden = false
            self.name_title.isHidden = false
            self.birthday_title.isHidden = false
            self.day_view.isHidden = false
            self.month_view.isHidden = false
            self.year_view.isHidden = false
        }else{
            if let frame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let height = frame.cgRectValue.height
                self.keyboardheight = height
                if DeviceType.iPhoneX {
                    print("testtest")
                    
                }else{
                    
                }
                if(userName_filed.isSelected) {
                    print("testtest")
                }else{
                    self.userName_filed.isHidden = true
                    self.name_title.isHidden = true
                    self.birthday_title.isHidden = true
                    self.day_view.isHidden = true
                    self.month_view.isHidden = true
                    self.year_view.isHidden = true
                    self.name_view.isHidden = true
                    if DeviceType.iPhoneX {
                        
                        bottom_height.constant = 20 + height
                    }else {
                        bottom_height.constant = 20 + height
                        
                    }
                }
                
                
            }
        }
       
    }
    @objc func hideKeyboard(notification: Notification) {
        self.userName_filed.isHidden = false
        self.name_title.isHidden = false
        self.birthday_title.isHidden = false
        self.day_view.isHidden = false
        self.month_view.isHidden = false
        self.year_view.isHidden = false
        self.name_view.isHidden = false
        if DeviceType.iPhoneX {
           
            if (self.keyboardheight != 0){
                bottom_height.constant = 20
            }
        }else {
            
            if (self.keyboardheight != 0){
                bottom_height.constant = 20
            }
        }
        
    }
   
    
    func initUI(){
        if DeviceType.iPhoneX {
            print("testtest")
            center_height.constant = 250
        }else{
            center_height.constant = 157
        }
        let date_gesture1 = UITapGestureRecognizer(target:self,action:#selector(self.DatePickerDialog))
        let date_gesture2 = UITapGestureRecognizer(target:self,action:#selector(self.DatePickerDialog))
        let date_gesture3 = UITapGestureRecognizer(target:self,action:#selector(self.DatePickerDialog))
        day_view.addGestureRecognizer(date_gesture1)
        month_view.addGestureRecognizer(date_gesture2)
        year_view.addGestureRecognizer(date_gesture3)
        let next_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Next_Page))
        next_view.addGestureRecognizer(next_gesture)
        if (AppData.shared.verification_type == "email"){
            self.mailphone_title.text = "My phone"
            phonenumberTextfiled = FPNTextField(frame: CGRect(x: 5, y: 5, width: mailphone_container.bounds.width - 5, height: mailphone_container.bounds.height - 5))
            phonenumberTextfiled.delegate = self
            phonenumberTextfiled.textColor = UIColor.init(red: 70/255, green: 69/255, blue: 77/255, alpha: 1.0)
            // phonenumberTextfiled.set(phoneNumber: AppData.shared.phoneCode + AppData.shared.phoneNumber)
            mailphone_container.addSubview(phonenumberTextfiled)
        }else {
           
            self.mailphone_title.text = "My e-mail"
            email_filed = UITextField (frame: CGRect(x: 10, y: 5, width: mailphone_container.bounds.width - 5, height: mailphone_container.bounds.height - 5))
            email_filed.textColor = UIColor.init(red: 70/255, green: 69/255, blue: 77/255, alpha: 1.0)
            
            mailphone_container.addSubview(email_filed)
        }
        
        
    }
  
    @objc func Email(textField: UITextField) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.showKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func DatePickerDialog(){
        let dateDialog = CustomDatePicker(title: "", day_lbl: self.birth_day, month_lbl: self.birth_month, year_lbl: self.birth_year,birthday: self.user_birthday)
        dateDialog.show(animated: true)
    }
    @objc func Next_Page(){
        let userName = self.userName_filed.text as! String
        if (userName.isEmpty) {
            AppData.shared.displayToastMessage("Please input name.")
            return
        }
        
       
        if (AppData.shared.verification_type == "email") {
            let phonecode = self.phonenumberTextfiled.text as! String
            if (phonecode.isEmpty) {
                AppData.shared.displayToastMessage("Please input phone Number.")
                return
            }
            AppData.shared.phoneNumber = self.phonenumberTextfiled.getRawPhoneNumber() as! String
        }else {
            let email = self.email_filed.text as! String
            if (email.isEmpty){
                AppData.shared.displayToastMessage("Please input email.")
                return
            }
            if (!isValidEmail(testStr: email)) {
                AppData.shared.displayToastMessage("Please input valid email.")
                return
            }
            AppData.shared.userEmail = email
        }
        let day_string = self.birth_day.text as! String
        let month_string = self.birth_month.text as! String
        let year_string = self.birth_year.text as! String
        self.user_birthday = year_string + "-" + month_string + "-" +  day_string
        if (self.user_birthday == "YYYY-MM-DD"){
                AppData.shared.displayToastMessage("Please select birthday.")
            return
        }
        AppData.shared.userName = userName
        
       
        AppData.shared.userBirthday = self.user_birthday
      
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "userprofilestep1VC") as! UserProfileStep1
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension UserProfileStep0: FPNTextFieldDelegate {
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code) // Output "France", "+33", "FR"
        AppData.shared.phoneCode = dialCode
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.showKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        if isValid {
            // Do something...
            textField.getFormattedPhoneNumber(format: .E164)          // Output "+33600000001"
            // Output "600000001"
        
        } else {
            // Do something...
        }
    }
    
}
