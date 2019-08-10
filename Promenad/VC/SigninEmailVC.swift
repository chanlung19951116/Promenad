//
//  SigninEmailVC.swift
//  Promenad
//
//  Created by LiuYan on 7/30/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class SigninEmailVC: UIViewController {
    
    @IBOutlet weak var back_btn: UIImageView!
    @IBOutlet weak var email_field: UITextField!
    
    @IBOutlet weak var password_field: UITextField!
    
    @IBOutlet weak var signin_btn: CardView!
    
    @IBOutlet weak var create_accountlbl: UILabel!
    
    @IBOutlet weak var bottom_height: NSLayoutConstraint!
    
    @IBOutlet weak var logi: UIImageView!
    var keyboardheight : CGFloat = 0
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
                logi.isHidden = true
            }else{
                logi.isHidden = true
            }
           
                if DeviceType.iPhoneX {
                    bottom_height.constant = 75.5 + height
                }else {
                    bottom_height.constant = 75.5 + height
                }
                
            
            
            
        }
    }
    @objc func hideKeyboard(notification: Notification) {
        if DeviceType.iPhoneX {
            logi.isHidden = false
            if (self.keyboardheight != 0){
                bottom_height.constant = 75.5
            }
        }else {
            logi.isHidden = false
            if (self.keyboardheight != 0){
                bottom_height.constant = 75.5
            }
        }
    }
    func initUI(){
        bottom_height.constant = 75.5
        let startcolor = UIColor(red: 142/255, green: 199/255, blue: 249/255, alpha: 1.0)
        let endcolor = UIColor(red: 52/255, green: 80/255, blue: 253/255, alpha: 1.0)
        self.signin_btn.backgroundColor = UIColor.fromGradientWithDirection(.topToBottom, frame: self.signin_btn.frame, colors: [startcolor, endcolor])
        let sign_phonegesture = UITapGestureRecognizer(target:self,action:#selector(self.Signin_Email))
        signin_btn.addGestureRecognizer(sign_phonegesture)
        let back_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Back_action))
        back_btn.addGestureRecognizer(back_gesture)
        back_btn.isUserInteractionEnabled = true
        let create_gesture = UITapGestureRecognizer(target:self,action:#selector(self.CreateAccount))
        create_accountlbl.addGestureRecognizer(create_gesture)
        create_accountlbl.isUserInteractionEnabled = true
    }
    @objc func Signin_Email(){
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "signupmbVC0") as! SignupMobileVC0
//        self.navigationController?.pushViewController(vc, animated: true)
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
        AppData.shared.showLoadingIndicator(view: self.view)
        EmailService().LoginByEmail(email: email, password: password) { (response) in
            DispatchQueue.main.async {
                
                if let json = response {
                    do {
                        AppData.shared.hideLoadingIndicator()
                        let resultData = json as! NSDictionary
                        let status = resultData["status"] as! String
                        if (status == "login") {
                            let authtoken = resultData["authToken"] as! String
                            AppData.shared.authToken = authtoken
                            UserDefaults.standard.set(AppData.shared.authToken, forKey: "auth_Token")
                            self.LoginInfo()
                        }else{
                            AppData.shared.displayToastMessage(status)
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
    @objc func CreateAccount(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "signupemailstep0VC") as! SignupEmailStep0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func LoginInfo(){
        UserService().LoadUserData(){ (response) in
            if let json = response {
                do {
                    let resultData = json as! NSDictionary
                    print(resultData)
                    AppData.shared.UserData = resultData["userData"] as! [String : Any]
                    let photoData = resultData["photos"] as! NSArray
                    AppData.shared.UserData["photos"] = photoData
                   
//                    let status = resultData["satus"] as! NSDictionary
//                    AppData.shared.UserData["satus"] = status
                    AppData.shared.UserData["isFullInfo"] = true
                    if let lat = AppData.shared.UserData["lat"] as? NSNull {
                        
                    }else {
                        if let lng = AppData.shared.UserData["lng"] as? NSNull {
                            
                        }else{
                            let lat = AppData.shared.UserData["lat"] as! String
                            let lng = AppData.shared.UserData["lng"] as! String
                            AppData.shared.my_lat = Double(lat) as! Double
                            AppData.shared.my_lng = Double(lng) as! Double
                        }
                    }
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "containVC") as! ContainVC
                    // self.present(verificationController, animated: true, completion: nil)
                    self.present(vc, animated: true, completion: nil)
                    
                }
                catch(let error){
                    AppData.shared.hideLoadingIndicator()
                    AppData.shared.displayToastMessage("Cannot get user me, please try it later.")
                    //print("Error Getting properties when logging in")
                    // print(error.localizedDescription)
                }
            }
            else {
                AppData.shared.displayToastMessage("Cannot get user me, please try it later.")
                print("Response was nil")
            }
        }
    }
}
