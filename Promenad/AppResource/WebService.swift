//
//  WebService.swift
//  Promenad
//
//  Created by LiuYan on 8/5/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import Foundation
import Alamofire
class MobileService {
    
    public func CheckVerifyCodeMobileNumber (phonecode: String, phoneNumber : String, request_id: String, otp: String, completionHandler:@escaping([String:Any]?)->Void){
        let body = ["phone_code": phonecode , "number": phoneNumber,"rid": request_id,"code": otp]
        Alamofire.request(AppConstant.mainUrl + "check_sms_code_login_register",
                          method: .post,
                          parameters: body).responseJSON { (response) in
                            
                            switch response.result {
                            case .success(let json):
                                let data = json as! [String:Any]
                                completionHandler(data)
                                break
                            case .failure(let error):
                                completionHandler(nil)
                                break
                            }
        }
        
    }
    public func StartGoSMSMobileNumber (phonecode: String, phoneNumber : String,completionHandler:@escaping([String:Any]?)->Void){
        let body = ["number" : phonecode + phoneNumber]
        Alamofire.request(AppConstant.mainUrl + "start_go_sms",
                          method: .post,
                          parameters: body).responseJSON { (response) in
                            
                            switch response.result {
                            case .success(let json):
                                let data = json as! [String:Any]
                                completionHandler(data)
                                break
                            case .failure(let error):
                                completionHandler(nil)
                                break
                            }
        }
        
    }
}
class UserService {
    public func LoadUserData(completionHandler:@escaping([String:Any]?)->Void){
        let headers = ["Authorization" : "Bearer " + AppData.shared.authToken]
        Alamofire.request(AppConstant.mainUrl + "load_user_data", method: .get,  headers: headers).responseJSON { (response) in
            
            switch response.result {
            case .success(let json):
                let data = json as! [String:Any]
                completionHandler(data)
                break
            case .failure(let error):
                completionHandler(nil)
                break
            }
        
        }
    }
}
class EmailService {
    public func LoginByEmail (email: String, password : String,completionHandler:@escaping([String:Any]?)->Void){
        let body = ["email" : email, "password" : password]
        Alamofire.request(AppConstant.mainUrl + "email_login",
                          method: .post,
                          parameters: body).responseJSON { (response) in
                            
                            switch response.result {
                            case .success(let json):
                                let data = json as! [String:Any]
                                completionHandler(data)
                                break
                            case .failure(let error):
                                completionHandler(nil)
                                break
                            }
        }
        
    }
    public func SendEmailVericatonURL (email: String, password : String,completionHandler:@escaping([String:Any]?)->Void){
        let body = ["email" : email]
        Alamofire.request(AppConstant.mainUrl + "email/send",
                          method: .post,parameters: body).responseJSON { (response) in
                            
                            switch response.result {
                            case .success(let json):
                                let data = json as! [String:Any]
                                completionHandler(data)
                                break
                            case .failure(let error):
                                completionHandler(nil)
                                break
                            }
        }
        
    }
    public func CheckEmailVerificationStatus(email: String,completionHandler:@escaping([String:Any]?)->Void){
        let body = ["email" : email]
        Alamofire.request(AppConstant.mainUrl + "email/check",
                          method: .post,parameters: body).responseJSON { (response) in
                            
                            switch response.result {
                            case .success(let json):
                                let data = json as! [String:Any]
                                completionHandler(data)
                                break
                            case .failure(let error):
                                completionHandler(nil)
                                break
                            }
        }
    }
    
}
class RegisterServic{
    public func Register_Phone(completionHandler:@escaping([String:Any]?)->Void){
        let uploadurl = AppConstant.mainUrl + "register_email"
        let body = ["phone_code": AppData.shared.phoneCode,"number": AppData.shared.phoneNumber,"email": AppData.shared.userEmail, "verification_type": "BETATEST", "name": AppData.shared.userName, "gender" : AppData.shared.userGender, "looking_for" : AppData.shared.userLooking_for,"land" : AppData.shared.user_country, "city": AppData.shared.user_city , "purpose_of_dating": AppData.shared.purpose_of_dating, "birth_date": AppData.shared.userBirthday, "interests": AppData.shared.user_Interest,"about":AppData.shared.user_about,"orientation": AppData.shared.userOrientation ,"weight": AppData.shared.userWeight,"height": AppData.shared.userHeight]
        Alamofire.upload(multipartFormData: { (formdata) in
            
            let filename = AppData.shared.userphotoFileName
            let mimeType = "image/jpg"
            //let filePath = URL(string: AppData.shared.userImageString)!
            formdata.append(AppData.shared.userImageString, withName:"avatar" , fileName: filename, mimeType: mimeType)
            for (key, value) in body
            {
                formdata.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
        }, to: uploadurl) { (result) in
            
            switch result {
            case .success(let upload, _,_):
                
                upload.responseJSON(completionHandler: { (response) in
                    
                    switch response.result {
                    case .success(let json):
                        
                        guard let data = json as? [String:Any] else {
                            completionHandler(nil)
                            return
                        }
                        completionHandler(data)
                        break
                    case .failure(let error):
                        print("Server Error While Uploading Photo")
                        print(error.localizedDescription)
                        completionHandler(nil)
                        break
                    }
                })
                break
            case .failure(let error):
                print("Encoding Result Error")
                print(error.localizedDescription)
                completionHandler(nil)
                break
            }
        }
    }

    public func Register_Email(completionHandler:@escaping(([String:Any]?)->Void)){
        let uploadurl = AppConstant.mainUrl + "register_email"
         let body = ["password": AppData.shared.userEmail_password,"email": AppData.shared.userEmail, "verification_type": "email", "name": AppData.shared.userName, "gender" : AppData.shared.userGender, "looking_for" : AppData.shared.userLooking_for,"land" : AppData.shared.user_country, "city": AppData.shared.user_city , "purpose_of_dating": AppData.shared.purpose_of_dating, "birth_date": AppData.shared.userBirthday, "interests": AppData.shared.user_Interest,"about":AppData.shared.user_about,"orientation": AppData.shared.userOrientation ,"weight": AppData.shared.userWeight,"height": AppData.shared.userHeight]
        Alamofire.upload(multipartFormData: { (formdata) in
            
            let filename = AppData.shared.userphotoFileName
            let mimeType = "image/jpg"
            //let filePath = URL(string: AppData.shared.userImageString)!
            formdata.append(AppData.shared.userImageString, withName:"avatar" , fileName: filename, mimeType: mimeType)
            for (key, value) in body
            {
                formdata.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            
        }, to: uploadurl) { (result) in
            
            switch result {
            case .success(let upload, _,_):
                
                upload.responseJSON(completionHandler: { (response) in
                    
                    switch response.result {
                    case .success(let json):
                        
                        guard let data = json as? [String:Any] else {
                            completionHandler(nil)
                            return
                        }
                        completionHandler(data)
                        break
                    case .failure(let error):
                        print("Server Error While Uploading Photo")
                        print(error.localizedDescription)
                        completionHandler(nil)
                        break
                    }
                })
                break
            case .failure(let error):
                print("Encoding Result Error")
                print(error.localizedDescription)
                completionHandler(nil)
                break
            }
        }
    }
}
class LoadUsersService {
    public func MatchUserList(completionHandler:@escaping([String:Any]?)->Void){
        let headers = ["Authorization" : "Bearer " + AppData.shared.authToken]
        Alamofire.request(AppConstant.mainUrl + "getmatches", method: .get,  headers: headers).responseJSON { (response) in
            
            switch response.result {
            case .success(let json):
                let data = json as! [String:Any]
                completionHandler(data)
                break
            case .failure(let error):
                completionHandler(nil)
                break
            }
            
        }
    }
    public func LoadUserList(tagUrl: String, completionHandler:@escaping(NSArray?)->Void){
        let headers = ["Authorization" : "Bearer " + AppData.shared.authToken]
        Alamofire.request(AppConstant.mainUrl + tagUrl, method: .get,  headers: headers).responseJSON { (response) in
            
            switch response.result {
            case .success(let json):
                let data = json as! NSArray
                completionHandler(data)
                break
            case .failure(let error):
                completionHandler(nil)
                break
            }
            
        }
    }
    public func CheckOnlineStatus(userid: String,completionHandler:@escaping([String:Any]?)->Void){
        let body = ["id" : userid]
        let headers = ["Authorization" : "Bearer " + AppData.shared.authToken]
        Alamofire.request(AppConstant.mainUrl + "check_user_online_status",
                          method: .post,parameters: body, headers: headers).responseJSON { (response) in
                            
                            switch response.result {
                            case .success(let json):
                                let data = json as! [String:Any]
                                completionHandler(data)
                                break
                            case .failure(let error):
                                completionHandler(nil)
                                break
                            }
        }
    }
    public func LoadOtherUserData(userid: String,completionHandler:@escaping([String:Any]?)->Void){
        let body = ["id" : userid, "flag" : "1"]
        let headers = ["Authorization" : "Bearer " + AppData.shared.authToken]
        Alamofire.request(AppConstant.mainUrl + "load_user_data_by_id",
                          method: .post,parameters: body, headers: headers).responseJSON { (response) in
                            
                            switch response.result {
                            case .success(let json):
                                let data = json as! [String:Any]
                                completionHandler(data)
                                break
                            case .failure(let error):
                                completionHandler(nil)
                                break
                            }
        }
    }
}
class NotificationService {
    public func GetNotificationHistory(completionHandler:@escaping([String:Any]?)->Void){
        let seconds = TimeZone.current.secondsFromGMT()
        let minutes = seconds/60
        let offsetfromUTC = String(minutes) as! String
        let body = ["utc_offset": offsetfromUTC]
        let headers = ["Authorization" : "Bearer " + AppData.shared.authToken]
        Alamofire.request(AppConstant.mainUrl + "notify_history",
                          method: .post,parameters: body, headers: headers).responseJSON { (response) in
                            
                            switch response.result {
                            case .success(let json):
                                let data = json as! [String:Any]
                                completionHandler(data)
                                break
                            case .failure(let error):
                                completionHandler(nil)
                                break
                            }
        }
    }
}
class MessageService{
    public func GetChatList(completionHandler:@escaping(NSArray?)->Void){
        let seconds = TimeZone.current.secondsFromGMT()
        let minutes = seconds/60
        let offsetfromUTC = String(minutes) as! String
        let body = ["utc_offset": offsetfromUTC + " minutes","flag" : "1"]
        let headers = ["Authorization" : "Bearer " + AppData.shared.authToken]
        Alamofire.request(AppConstant.mainUrl + "chat_list_data",
                          method: .post,parameters: body, headers: headers).responseJSON { (response) in
                            
                            switch response.result {
                            case .success(let json):
                                let data = json as! NSArray
                                completionHandler(data)
                                break
                            case .failure(let error):
                                completionHandler(nil)
                                break
                            }
        }
    }
    public func LoadMessages(user_id: String,completionHandler:@escaping(NSArray?)->Void){
        let seconds = TimeZone.current.secondsFromGMT()
        let minutes = seconds/60
        let offsetfromUTC = String(minutes) as! String
        let body = ["utc_offset": offsetfromUTC + " minutes","goid" : user_id]
        let headers = ["Authorization" : "Bearer " + AppData.shared.authToken]
        Alamofire.request(AppConstant.mainUrl + "loadmsges",
                          method: .post,parameters: body, headers: headers).responseJSON { (response) in
                            
                            switch response.result {
                            case .success(let json):
                                let msgdata = json as! NSDictionary
                                let data = msgdata["data"] as! NSArray
                                completionHandler(data)
                                break
                            case .failure(let error):
                                completionHandler(nil)
                                break
                            }
        }
    }
    public func SendMessage(user_id: String,msg: String,completionHandler:@escaping([String : Any]?)->Void){
        let seconds = TimeZone.current.secondsFromGMT()
        let minutes = seconds/60
        let offsetfromUTC = String(minutes) as! String
        let body = ["timeZone": offsetfromUTC + " minutes","goid" : user_id,"mess" : msg]
        let headers = ["Authorization" : "Bearer " + AppData.shared.authToken]
        Alamofire.request(AppConstant.mainUrl + "send_msg",
                          method: .post,parameters: body, headers: headers).responseJSON { (response) in
                            
                            switch response.result {
                            case .success(let json):
                                let data = json as! [String: Any]
                                completionHandler(data)
                                break
                            case .failure(let error):
                                completionHandler(nil)
                                break
                            }
        }
    }
    
    
}
class UserLocationService {
    public func NearByUsers(age: String, purpose:String, completionHandler:@escaping(NSArray?)->Void){
        let seachUrl = "?lat=" + String(AppData.shared.my_lat) + "&lng=" + String(AppData.shared.my_lng) + "&limit="
         + AppConstant.limit_for_nearbyusers + "&age=" + age + "&purpose_of_dating=" + purpose
        let headers = ["Authorization" : "Bearer " + AppData.shared.authToken]
        Alamofire.request(AppConstant.mainUrl + "searchPeople" + seachUrl,
                          method: .get, headers: headers).responseJSON { (response) in
                            
                            switch response.result {
                            case .success(let json):
                                let data = json as! NSArray
                                completionHandler(data)
                                break
                            case .failure(let error):
                                completionHandler(nil)
                                break
                            }
        }
    }
}
