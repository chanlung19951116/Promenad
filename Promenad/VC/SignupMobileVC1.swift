//
//  SignupMobileVC1.swift
//  Promenad
//
//  Created by LiuYan on 7/30/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit
import SVPinView
class SignupMobileVC1: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var back_btn: UIImageView!
    
    @IBOutlet weak var pinCodeView: SVPinView!
    
    @IBOutlet weak var resend_btn: UILabel!
    
    @IBOutlet weak var bottom_height: NSLayoutConstraint!
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
                logo.isHidden = true
            }else{
                logo.isHidden = true
            }
           
            if DeviceType.iPhoneX {
                bottom_height.constant = 200 + height
            }else {
                bottom_height.constant = 100 + height
                
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
                bottom_height.constant = 200
            }
        }
    }
    func initUI(){
        if (DeviceType.iPhoneX) {
            bottom_height.constant = 200
        }else {
            bottom_height.constant = 100
        }
        let back_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Back_action))
        back_btn.addGestureRecognizer(back_gesture)
        back_btn.isUserInteractionEnabled = true
        pinCodeView.didFinishCallback = { pin in
            self.CheckVerifyCode()
        }
    }
    @objc func Back_action(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    func CheckVerifyCode(){
        
        AppData.shared.showLoadingIndicator(view: self.view)
        MobileService().CheckVerifyCodeMobileNumber(phonecode: AppData.shared.phoneCode, phoneNumber: AppData.shared.phoneNumber, request_id: AppData.shared.rid, otp: self.pinCodeView.getPin()){ (response) in
            DispatchQueue.main.async {
                
                if let json = response {
                    do {
                        AppData.shared.hideLoadingIndicator()
                        let resultData = json as! NSDictionary
                        let responseString = AppData.shared.convertDictionaryToJsonString(response: json)
                        print(responseString)
                        let status = resultData["status"] as! String
                        if (status == "register first time" || status == "register invite" || status == "register no invite") {
                            AppData.shared.verification_type = "phone"
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyBoard.instantiateViewController(withIdentifier: "profilestep0") as! UserProfileStep0
                            // self.present(verificationController, animated: true, completion: nil)
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else if (status == "login") {
                            AppData.shared.authToken = resultData["authToken"] as! String
                            UserDefaults.standard.set(AppData.shared.authToken, forKey: "auth_Token")
                            self.LoginInfo()
                            
                        }else{
                            AppData.shared.displayToastMessage("Invalid SMS verification code, retry after 5 minutes")
                           
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
    func LoginInfo(){
        UserService().LoadUserData(){ (response) in
            if let json = response {
                do {
                    let resultData = json as! NSDictionary
                    AppData.shared.UserData = resultData["userData"] as! [String : Any]
                    let photoData = resultData["photos"] as! NSArray
                    AppData.shared.UserData["photos"] = photoData
                    let status = resultData["satus"] as! NSDictionary
                    AppData.shared.UserData["satus"] = status
                    AppData.shared.UserData["isFullInfo"] = true
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
