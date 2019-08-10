//
//  SignupEmailStep0.swift
//  Promenad
//
//  Created by LiuYan on 7/30/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class SignupEmailStep0: UIViewController {
    
    @IBOutlet weak var back_btn: UIImageView!
    
    @IBOutlet weak var email_field: UITextField!
    
    @IBOutlet weak var password_field: UITextField!
    
    @IBOutlet weak var confirm_passwordfield: UITextField!
    
    @IBOutlet weak var signup_btn: CardView!
    
    
    @IBOutlet weak var bottom_height: NSLayoutConstraint!
    
    @IBOutlet weak var logo: UIImageView!
    var keyboardheight: CGFloat = 0
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
            
            if DeviceType.iPhoneX {
                bottom_height.constant = 50 + height
            }else {
                bottom_height.constant = 50 + height
            }
            
            
            
            
        }
    }
    @objc func hideKeyboard(notification: Notification) {
        if DeviceType.iPhoneX {
            logo.isHidden = false
            if (self.keyboardheight != 0){
                bottom_height.constant = 50
            }
        }else {
            logo.isHidden = false
            if (self.keyboardheight != 0){
                bottom_height.constant = 50
            }
        }
    }
    func initUI(){
        bottom_height.constant = 50
        let startcolor = UIColor(red: 142/255, green: 199/255, blue: 249/255, alpha: 1.0)
        let endcolor = UIColor(red: 52/255, green: 80/255, blue: 253/255, alpha: 1.0)
        self.signup_btn.backgroundColor = UIColor.fromGradientWithDirection(.topToBottom, frame: self.signup_btn.frame, colors: [startcolor, endcolor])
        let sign_phonegesture = UITapGestureRecognizer(target:self,action:#selector(self.Signup_Email))
        signup_btn.addGestureRecognizer(sign_phonegesture)
        let back_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Back_action))
        back_btn.addGestureRecognizer(back_gesture)
        back_btn.isUserInteractionEnabled = true
    }
    @objc func Signup_Email(){
        let email = self.email_field.text as! String
        if (email.isEmpty){
            AppData.shared.displayToastMessage("Please input email.")
            return
        }
        if (!isValidEmail(testStr: email)){
            AppData.shared.displayToastMessage("Please input valid email.")
            return
        }
        let password = self.password_field.text as! String
        if (password.isEmpty){
            AppData.shared.displayToastMessage("Please input password.")
            return
        }
        if (password.count < 8){
            AppData.shared.displayToastMessage("The password must be at least 8 characters.")
            return
        }
        let con_password = self.password_field.text as! String
        if (con_password.isEmpty){
            AppData.shared.displayToastMessage("Please input confirm password.")
            return
        }
        if (con_password != password) {
            AppData.shared.displayToastMessage("Password isn't matched.")
            return
        }
        AppData.shared.showLoadingIndicator(view: self.view)
        EmailService().SendEmailVericatonURL(email: email, password: password) { (response) in
            DispatchQueue.main.async {
                
                if let json = response {
                    do {
                        AppData.shared.hideLoadingIndicator()
                        let resultData = json as! NSDictionary
                        let status = resultData["status"] as! Int
                        let description = resultData["description"] as! String
                        if (status == 1) {
                            AppData.shared.userEmail = email
                            AppData.shared.userEmail_password = password
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyBoard.instantiateViewController(withIdentifier: "signupemailstep1VC") as! SignupEmailStep1
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        }else{
                            AppData.shared.displayToastMessage(description)
                        }
                    }
                    catch(let error){
                        AppData.shared.hideLoadingIndicator()
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
