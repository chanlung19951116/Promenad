//
//  AppData.swift
//  Promenad
//
//  Created by LiuYan on 7/29/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
class AppData{
    
    static let shared: AppData = {
        return AppData()
    }()
    var loadingNotification: MBProgressHUD!
    public var index: Int = 0
    public var recognizers : [UIGestureRecognizer]!
    public var countries = NSArray()
    //Save Data
    public var verification_type: String = ""
    public var phoneCode : String = ""
    public var phoneNumber: String = ""
    public var rid : String = ""
    public var authToken : String = ""
    public var userName: String = ""
    public var userEmail : String = ""
    public var userBirthday : String = ""
    public var userGender: String = ""
    public var userLooking_for: String = ""
    public var purpose_of_dating: String = ""
    public var user_country: String = ""
    public var user_city: String = ""
    public var user_about: String = ""
    public var user_Interest: String = ""
    public var userEmail_password: String = ""
    public var userOrientation: String = "Bisexual"
    public var userHeight: String = "5'11\""
    public var userWeight: String = "76"
    public var userImageString: URL!
    public var userphotoFileName :String = ""
    public var my_lat: Double = 0
    public var my_lng: Double = 0
    
    public var DatingPurposeArray : [String] = ["Flirt","Travels","Serious relationship","Friendship","Sex"]
    public var DatingPurposeDisplayArray : [String] = ["Flirt","Travels","Serious\nrelationship","Friendship","Sex"]
    
    //User Data...........
    public var UserData = [String: Any]()
    public var ChatData = NSArray()
    func SetNextButton(button : UILabel!) {
        button.layer.backgroundColor = AppConstant.Btn_BgColor.cgColor
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 2
        button.layer.borderColor = AppConstant.Btn_BorderColor.cgColor
        button.layer.masksToBounds = true
    }
    func SetFontButton(button : UILabel!){
//        let fontSize = button.font.pointSize
//        button.te = UIFont(name: "opensans_regular", size: fontSize)
    }
    func readJSONFromFile(fileName: String) -> Any?
    {
        var json: Any?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                json = try? JSONSerialization.jsonObject(with: data)
            } catch {
                // Handle error here
            }
        }
        return json
    }
    func convertDictionaryToJsonString(response: [String: Any])->String {
        let jsonData = try! JSONSerialization.data(withJSONObject: response, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        return decoded
    }
    func displayToastMessage(_ message : String) {
        
        let toastView = UILabel()
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastView.textColor = UIColor.white
        toastView.textAlignment = .center
        toastView.font = UIFont.preferredFont(forTextStyle: .caption1)
        toastView.layer.cornerRadius = 25
        toastView.layer.masksToBounds = true
        toastView.text = message
        toastView.numberOfLines = 0
        toastView.alpha = 0
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        let window = UIApplication.shared.delegate?.window!
        window?.addSubview(toastView)
        
        let horizontalCenterContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .centerX, relatedBy: .equal, toItem: window, attribute: .centerX, multiplier: 1, constant: 0)
        
        let widthContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 275)
        
        let verticalContraint: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=200)-[loginView(==50)]-68-|", options: [.alignAllCenterX, .alignAllCenterY], metrics: nil, views: ["loginView": toastView])
        
        NSLayoutConstraint.activate([horizontalCenterContraint, widthContraint])
        NSLayoutConstraint.activate(verticalContraint)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            toastView.alpha = 1
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                toastView.alpha = 0
            }, completion: { finished in
                toastView.removeFromSuperview()
            })
        })
    }
    func showLoadingIndicator(view: UIView){
        loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.bezelView.color = UIColor(red: 35, green: 0, blue: 0, alpha: 0.1)
        loadingNotification.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
    }
    func hideLoadingIndicator(){
        loadingNotification.hide(animated: true)
    }
}
