//
//  Helper.swift
//  Promenad
//
//  Created by LiuYan on 8/4/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
struct ScreenSize  {
    static let Width         = UIScreen.main.bounds.size.width
    static let Height        = UIScreen.main.bounds.size.height
    static let Max_Length    = max(ScreenSize.Width, ScreenSize.Height)
    static let Min_Length    = min(ScreenSize.Width, ScreenSize.Height)
}
struct DeviceType {
    static let iPhone4  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.Max_Length < 568.0
    static let iPhone5_5s  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.Max_Length == 568.0
    static let iPhone6_6s_7 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.Max_Length == 667.0
    static let iPhone6P_6sP_7P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.Max_Length == 736.0
    static let iPhoneX = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.Max_Length == 812.0
    static let iPad = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.Max_Length == 1024.0
}
func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}
func FolderUrl(filename:String)->URL{
    let directory = mortgagesImageDirectory().appendingPathComponent(filename,isDirectory:true)
    
    let fileManager = FileManager.init()
    if(!fileManager.fileExists(atPath:directory.relativePath)){
        do{
            try fileManager.createDirectory(atPath:directory.relativePath, withIntermediateDirectories:true, attributes:[:])
        }
        catch(let e){
            print("Error creating Directory at Path \(directory.relativePath)")
            print("\(e.localizedDescription)")
        }
    }
    return directory
}
func mortgagesImageDirectory()->URL{
    let directory = URL(fileURLWithPath:baseFileDirectory()).appendingPathComponent("Userphoto")
    return directory
}
func baseFileDirectory()->String{
    return NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .allDomainsMask, true).first!
}
public func saveProfileImage(imageData:Data)->Bool{
    
    var saved = true
    do {
        try imageData.write(to: ProfilePhotoFilePath(), options: .atomic)
    }
    catch(let e){
        
        saved = false
        print("Error Saving Agents Photo To File System")
        print("\(e.localizedDescription)")
    }
    return saved
}
 public func ProfilePhotoFilePath()->URL{
    
    let filename = "profile.jpg"
    let urlPath = URL(fileURLWithPath: FolderUrl(filename: filename).relativePath).appendingPathComponent(filename)
    return urlPath
}
public func getAge(birthdate: String)->String{
    let currentDate = Date()
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "yyyy-MM-dd"
    let currentString = dateformatter.string(from: currentDate)
    
    let birthdateStrings = birthdate.components(separatedBy: "-")
    let currentStrings = currentString.components(separatedBy: "-")
    let birthyear = birthdateStrings[0]
    let birthmonth = birthdateStrings[1]
    let birthday = birthdateStrings[2]
    let currentyear = currentStrings[0]
    let currentmonth = currentStrings[1]
    let currentday = currentStrings[2]
    var age = Int(currentyear)! - Int(birthyear)!
//    if (Int(currentmonth)! > Int(birthmonth)! || (Int(currentmonth)! == Int(birthmonth) && Int(currentday)! > Int(birthday)!)) {
//        age = age - 1
//    }
    let ageStr = String(age) as! String
    return ageStr
    
}
public func photoUrl(avatar: String)->String {
    if (avatar.contains(AppConstant.serverUrl + AppConstant.photoUrl)){
        return avatar
    }else{
        let url = AppConstant.serverUrl + AppConstant.photoUrl + avatar
        return url
    }
}
public func GetDistance(lat: Double, lng: Double)->String{
    let me_latstr = AppData.shared.UserData["lat"] as! String
    let me_lngstr = AppData.shared.UserData["lng"] as! String
    let me_lat = Double(me_latstr) as! Double
    let me_lng = Double(me_lngstr) as! Double
    let me_coor = CLLocation(latitude: me_lat, longitude: me_lng)
    let user_coor = CLLocation(latitude: lat, longitude: lng)
    let distance = user_coor.distance(from: me_coor)
    let distance_show = distance / 100
    let int_dist = Int(distance_show) as! Int
    let double_dist = Double(int_dist) / 10
    let result_str = String(double_dist) as! String
    return result_str
}
public func CompareDateStrings(first: String, second: String)->String {
    let firstarray = first.components(separatedBy: " ")
    let secondarray = second.components(separatedBy: " ")
    
    let first_daystrings = firstarray[0].components(separatedBy: "-")
    let first_timestrings = firstarray[1].components(separatedBy: ":")
    let second_daystrings = secondarray[0].components(separatedBy: "-")
    let second_timestrings = secondarray[1].components(separatedBy: ":")
    let f_year = Int(first_daystrings[0]) as! Int
    let f_month = Int(first_daystrings[1]) as! Int
    let f_day = Int(first_daystrings[2]) as! Int
    let f_hh = Int(first_timestrings[0]) as! Int
    let f_mm = Int(first_timestrings[1]) as! Int
    let f_ss = Int(first_timestrings[2]) as! Int
   
    let s_year = Int(second_daystrings[0]) as! Int
    let s_month = Int(second_daystrings[1]) as! Int
    let s_day = Int(second_daystrings[2]) as! Int
    let s_hh = Int(second_timestrings[0]) as! Int
    let s_mm = Int(second_timestrings[1]) as! Int
    let s_ss = Int(second_timestrings[2]) as! Int
    print("check day")
    print(f_hh)
    print(s_hh)
    print(f_mm)
    print(s_mm)
    print(f_ss)
    print(s_ss)
    
    print("*******")
    var resultstring: String = ""
    if (f_month > s_month){
        let month_value = f_month - s_month
        let resultString = String(month_value) as! String
        if (month_value > 1){
            resultstring =  resultString + "months ago"
        }else{
            resultstring =  resultString + "month ago"
        }
        
    }else if (f_month == s_month){
        if (f_day > s_day){
            let month_value = f_day - s_day
            let resultString = String(month_value) as! String
            if (month_value > 1){
                resultstring =  resultString + "days ago"
            }else{
                resultstring =  resultString + "day ago"
            }
        }else if (f_day == s_day){
            if (f_hh > s_hh){
                let month_value = f_hh - s_hh
                let resultString = String(month_value) as! String
                if (month_value > 1){
                    resultstring =  resultString + "hours ago"
                }else{
                    resultstring =  resultString + "hour ago"
                }
            }else if (f_hh == s_hh){
                if (f_mm > s_mm) {
                    let month_value = f_mm - s_mm
                    let resultString = String(month_value) as! String
                    if (month_value > 1){
                        resultstring =  resultString + "minutes ago"
                    }else{
                        resultstring =  resultString + "minute ago"
                    }
                }else if (f_mm == s_mm){
                    if (f_ss > s_ss){
                        let month_value = f_ss - s_ss
                        let resultString = String(month_value) as! String
                        if (month_value > 1){
                            resultstring =  resultString + "seconds ago"
                        }else{
                            resultstring =  resultString + "second ago"
                        }
                    }else {
                         resultstring =  "just now"
                    }
                }else{
                    resultstring =  "just now"
                }
                
            }else {
                resultstring =  "just now"
            }
        }
    }
    return resultstring
}
func CheckOnline(user_id: String, imageView: UIImageView){
    LoadUsersService().CheckOnlineStatus(userid: user_id){ (response) in
        DispatchQueue.main.async {
            if let json = response {
                do {
                    
                    let resultData = json as! NSDictionary
                    let jsonString = AppData.shared.convertDictionaryToJsonString(response: resultData as! [String : Any]) as! String
                    let status = resultData["status"] as! String
                    if (status == "offline") {
                        imageView.isHidden = true
                    }else {
                        imageView.isHidden = false
                    }
                }
                catch(let error){
                    
                }
            }
            else {
                // AppData.shared.displayToastMessage("Cannot get user me, please try it later.")
                print("Response was nil")
            }
        }
        
    }
}
func ConvertMilliSecondstoDate(datemilliseconds: String)->String{
    var milliseconds = Double(datemilliseconds) as! Double
    var date = Date(timeIntervalSince1970: (milliseconds / 1000.0))
    var dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    let resultstr = dateFormatter.string(from: date)
    let strings = resultstr.components(separatedBy: " ")
    return strings[1]
}
func GetLatitudeandLongitude(distance: Double, alpha : Double)->[String : Any]{
    let distRadians = distance / (6372797.6)
    // print(distRadians)
    let lat = distRadians * sin(alpha) +  (AppData.shared.my_lat / 180) * Double.pi
    let lng = distRadians * cos(alpha) + (AppData.shared.my_lng / 180) * Double.pi
    let lat_angle = lat * 180 / Double.pi
    let lng_angle = lng * 180 / Double.pi
    let result: [String: Any] = ["lat" : lat_angle, "lng" : lng_angle]
    return result
}
