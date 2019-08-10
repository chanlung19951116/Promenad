//
//  AppConstant.swift
//  Promenad
//
//  Created by LiuYan on 7/29/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import Foundation
import UIKit
public class AppConstant {
    static let Btn_BorderColor : UIColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
    static let Btn_BgColor: UIColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1.0)
    static let langauges : [String] = ["Akan", "Amharic", "Arabic","Assamese", "Azerbaijani", "Balochi","Belarusian", "Bengali", "Bhojpuri","Burmese", "Cebuano", "Chewa","Chhattisgarhi", "Czech", "Deccan","Dhundhari", "Dutch", "Eastern Min","English", "French", "Fula","Gan Chinese"]
    static let professions: [String] = ["Actor", "Adjuster", "Administrator","Agronomist", "Anesthesiologist", "Animator","Announcer", "Architect", "Art","Artist", "Assistant", "Astronaut","Astronomer", "Astrophysicist", "Auditor", "Baker", "Banker","Barista", "Barman", "Biotechnologist","Bodyguard", "Bookkeeper", "Botanist"]
    static let religions = ["Atheism", "Agnosticism", "Judaism","Orthodoxy", "Catholicism", "Protestantism","Islam", "Buddhism", "Confucianism","Secular Humanism", "Pastafarianism"]
   //Real WEBserver
//    static let mainUrl : String = "https://gopromenad.com/api/"
//    static let serverUrl : String = "https://gopromenad.com"
//    static let photoUrl: String = "/uploads/photos/"
    //Dev Server...
    static let mainUrl : String = "https://dev-prom.prmnd.com/api/"
    static let serverUrl : String = "https://dev-prom.prmnd.com/"
    static let photoUrl: String = "/uploads/photos/"
    static let limit_for_nearbyusers = "100"
}
