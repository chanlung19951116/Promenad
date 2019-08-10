//
//  SignupMobileVC0.swift
//  Promenad
//
//  Created by LiuYan on 7/30/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit
import FlagPhoneNumber
class SignupMobileVC0: UIViewController {

    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var phoneView: CardView!
    var phonenumberTextfiled: FPNTextField!
    @IBOutlet weak var signup_btn: CardView!
    
    @IBOutlet weak var back_btn: UIImageView!
    
    @IBOutlet weak var bottom_height: NSLayoutConstraint!
    var keyboardheight : CGFloat = 0
    
    var keyboardFlag: Int = 0
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
            if DeviceType.iPhoneX {
                print("testtest")
                logo.isHidden = true
            }else{
                logo.isHidden = true
            }
            if (self.keyboardFlag == 0){
                if DeviceType.iPhoneX {
                    bottom_height.constant = 200 + height
                }else {
                    bottom_height.constant = 100 + height
                }
                
            }
           
            
        }
    }
    @objc func hideKeyboard(notification: Notification) {
            if DeviceType.iPhoneX {
                logo.isHidden = false
                if (self.keyboardheight != 0){
                    bottom_height.constant = 200
                }
            }else {
                logo.isHidden = false
                if (self.keyboardheight != 0){
                    bottom_height.constant = 100
                }
            }
    }
    
    func initUI(){
        if (DeviceType.iPhoneX) {
            bottom_height.constant = 200
        }else {
             bottom_height.constant = 100
        }
        phonenumberTextfiled = FPNTextField(frame: CGRect(x: 5, y: 5, width: phoneView.bounds.width - 5, height: phoneView.bounds.height - 5))
        phonenumberTextfiled.delegate = self
        phoneView.addSubview(phonenumberTextfiled)
        let startcolor = UIColor(red: 142/255, green: 199/255, blue: 249/255, alpha: 1.0)
        let endcolor = UIColor(red: 52/255, green: 80/255, blue: 253/255, alpha: 1.0)
        self.signup_btn.backgroundColor = UIColor.fromGradientWithDirection(.topToBottom, frame: self.signup_btn.frame, colors: [startcolor, endcolor])
        let sign_phonegesture = UITapGestureRecognizer(target:self,action:#selector(self.Signin_phone))
        signup_btn.addGestureRecognizer(sign_phonegesture)
        let back_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Back_action))
        back_btn.addGestureRecognizer(back_gesture)
        back_btn.isUserInteractionEnabled = true
        
    }
    @objc func Signin_phone(){
      self.view.endEditing(true)
       let check_number = self.phonenumberTextfiled.text as! String
        if (check_number.isEmpty){
            AppData.shared.displayToastMessage("Please input phoneNumber.")
            return
        }
        AppData.shared.phoneNumber = self.phonenumberTextfiled.getRawPhoneNumber() as! String
        AppData.shared.showLoadingIndicator(view: self.view)
        MobileService().StartGoSMSMobileNumber(phonecode: AppData.shared.phoneCode, phoneNumber: AppData.shared.phoneNumber) { (response) in
            DispatchQueue.main.async {
                
                if let json = response {
                    do {
                       AppData.shared.hideLoadingIndicator()
                       let resultData = json as! NSDictionary
                       let responseString = AppData.shared.convertDictionaryToJsonString(response: json)
                        print(responseString)
                        if (responseString.contains("ok")){
                            let status = resultData["status"] as! String
                            if (status == "ok"){
                                AppData.shared.rid = resultData["rid"] as! String
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let vc = storyBoard.instantiateViewController(withIdentifier: "signupmbVC1") as! SignupMobileVC1
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }else {
                            let status = resultData["status"] as! String
                            let code = Int(status) as! Int
                            AppData.shared.displayToastMessage(ErrorMsg().getErrorMsg(code: code))
                            
                        }
                    }
                    catch(let error){
                        AppData.shared.hideLoadingIndicator()
                        //print("Error Getting properties when logging in")
                       // print(error.localizedDescription)
                    }
                }
                else {
                    AppData.shared.hideLoadingIndicator()
                    print("Response was nil")
                }
            }
            
        }
        
        
        
    }
    @objc func Back_action(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
extension SignupMobileVC0: FPNTextFieldDelegate {
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        //self.view.endEditing(true)
        print(name, dialCode, code) // Output "France", "+33", "FR"
        AppData.shared.phoneCode = dialCode
        
        
    }
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            // Do something...
            self.keyboardFlag = 1
            textField.getFormattedPhoneNumber(format: .E164)          // Output "+33600000001"
            print("checking")                    // Output "600000001"
        } else {
            // Do something...
        }
    }
}
