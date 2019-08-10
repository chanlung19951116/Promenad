//
//  DetailVC.swift
//  Promenad
//
//  Created by LiuYan on 8/2/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit
import moa
import Auk
class DetailVC: UIViewController {

    
    @IBOutlet weak var back_btn: UIImageView!
    @IBOutlet weak var user_photoslider: UIScrollView!
    @IBOutlet weak var user_photoView: UICollectionView!
    
   
    @IBOutlet weak var user_InterestView: UICollectionView!
    
    
    @IBOutlet weak var interestView_height: NSLayoutConstraint! // 73 default height
    @IBOutlet weak var usertotalView_height: NSLayoutConstraint!
    
    @IBOutlet weak var notify_btn: UIImageView!
    var UserData = NSDictionary()
    var photoData = NSArray()
    var interestArray: [String] = []
    
    //User DetailView  ..
    @IBOutlet weak var user_statusImage: UIImageView!
    @IBOutlet weak var userName_AgeLbl: UILabel!
    @IBOutlet weak var distance_lbl: UILabel!
    @IBOutlet weak var userAbout_Lbl: UILabel!
    @IBOutlet weak var user_onlineImage: UIImageView!
    @IBOutlet weak var user_Addresslbl: UILabel!
    @IBOutlet weak var user_OrientationLbl: UILabel!
    @IBOutlet weak var user_IamhereLbl: UILabel!
    @IBOutlet weak var user_ChildrenLbl: UILabel!
    @IBOutlet weak var user_RelationshipStatusLbl: UILabel!
    @IBOutlet weak var user_LanguagesLbl: UILabel!
    @IBOutlet weak var user_GrowthLbl: UILabel!
    @IBOutlet weak var user_WeightLbl: UILabel!
    @IBOutlet weak var user_EthnosLbl: UILabel!
    @IBOutlet weak var user_ProfessionLbl: UILabel!
    @IBOutlet weak var user_PlaceofworkLbl: UILabel!
    @IBOutlet weak var user_WorldviewLbl: UILabel!
    @IBOutlet weak var user_PoliticalViewLbl: UILabel!
    @IBOutlet weak var user_PersonalpriorityLbl: UILabel!
    @IBOutlet weak var user_ImportantinothersLbl: UILabel!
    @IBOutlet weak var user_ViewsonSmokingLbl: UILabel!
    @IBOutlet weak var user_ViewsonAlcholLbl: UILabel!
    
    @IBOutlet weak var photo_height: NSLayoutConstraint! // 168 default height
    //sub heights.........(15)
    
    @IBOutlet weak var user_addressheight1: NSLayoutConstraint!
    @IBOutlet weak var user_addressheight2: NSLayoutConstraint!
    @IBOutlet weak var user_orientationheight1: NSLayoutConstraint!
    @IBOutlet weak var user_orientationheight2: NSLayoutConstraint!
    @IBOutlet weak var user_iamhereheight1: NSLayoutConstraint!
    @IBOutlet weak var user_iamhereheight2: NSLayoutConstraint!
    @IBOutlet weak var user_childrenheight1: NSLayoutConstraint!
    @IBOutlet weak var user_childrenheight2: NSLayoutConstraint!
    @IBOutlet weak var user_relationshipheight1: NSLayoutConstraint!
    @IBOutlet weak var user_relationshipheight2: NSLayoutConstraint!
    @IBOutlet weak var user_languageheight1: NSLayoutConstraint!
    @IBOutlet weak var user_languageheight2: NSLayoutConstraint!
    @IBOutlet weak var user_growthheight1: NSLayoutConstraint!
    @IBOutlet weak var user_growthheight2: NSLayoutConstraint!
    @IBOutlet weak var user_weightheight1: NSLayoutConstraint!
    @IBOutlet weak var user_weightheight2: NSLayoutConstraint!
    @IBOutlet weak var user_ethnosheight1: NSLayoutConstraint!
    @IBOutlet weak var user_ethnosheight2: NSLayoutConstraint!
    @IBOutlet weak var user_professionheight1: NSLayoutConstraint!
    @IBOutlet weak var user_professionheight2: NSLayoutConstraint!
    @IBOutlet weak var user_placeofworkheight1: NSLayoutConstraint!
    @IBOutlet weak var user_placeofworkheight2: NSLayoutConstraint!
    @IBOutlet weak var user_worldviewheight1: NSLayoutConstraint!
    @IBOutlet weak var user_worldviewheight2: NSLayoutConstraint!
    @IBOutlet weak var user_politicalviewheight1: NSLayoutConstraint!
    @IBOutlet weak var user_politicalviewheight2: NSLayoutConstraint!
    @IBOutlet weak var user_personalpriorityheight1: NSLayoutConstraint!
    @IBOutlet weak var user_personalpriorityheight2: NSLayoutConstraint!
    @IBOutlet weak var user_importantinotherheight1: NSLayoutConstraint!
    @IBOutlet weak var user_importantinotherheight2: NSLayoutConstraint!
    @IBOutlet weak var user_viewonsmokingheight1: NSLayoutConstraint!
    @IBOutlet weak var user_viewonsmokingheight2: NSLayoutConstraint!
    @IBOutlet weak var user_viewonalcholheight1: NSLayoutConstraint!
    @IBOutlet weak var user_viewonalcholheight2: NSLayoutConstraint!
    
    @IBOutlet weak var subview_height: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    func initUI(){
         navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
       
        self.user_photoslider.auk.settings.contentMode = .scaleAspectFill
        self.user_photoslider.auk.settings.pageControl.backgroundColor = UIColor.clear
    
        let back_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Back_action))
        self.back_btn.isUserInteractionEnabled = true
        self.back_btn.addGestureRecognizer(back_gesture)
        
        let notify_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Notification))
        self.notify_btn.isUserInteractionEnabled = true
        self.notify_btn.addGestureRecognizer(notify_gesture)
        self.LoadProfileData()
    }
    @objc func Back_action(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    @objc func Notification(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "assistantVC") as! AssistantVC
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func LoadProfileData(){
        print(self.UserData)
        let user_Data = self.UserData["userData"] as! NSDictionary
        //First part
        let username = user_Data["name"] as! String
        let birth_date = user_Data["birth_date"] as! String
        let ageStr = getAge(birthdate: birth_date)
        if (ageStr !=  "-1"){
            self.userName_AgeLbl.text = username + " " + ageStr
        }else {
            self.userName_AgeLbl.text = username
        }
       
//        let status1 = user_Data["online"] as! String
//        if (status1 == "false") {
//            self.user_onlineImage.isHidden = true
//        }else {
//            self.user_onlineImage.isHidden = false
//        }
        let id = AppData.shared.UserData["id"] as! Int
        let user_id = String(id) as! String
        CheckOnline(user_id: user_id, imageView: self.user_onlineImage)
       
        let status = self.UserData["status"] as! NSDictionary
        let match_status = status["matched"] as! Bool
       
        let like_status = status["like"] as! Bool
        if (match_status == true){
            self.user_statusImage.image = UIImage(named: "match_message")
        }else {
            if (like_status == true){
                self.user_statusImage.image = UIImage(named: "match_dislike")
            }else {
                self.user_statusImage.image = UIImage(named: "match_like")
            }
        }
        
        if let userabout = user_Data["about"] as? NSNull {
             self.userAbout_Lbl.text = ""
        }else{
            let userabout = user_Data["about"] as! String
            self.userAbout_Lbl.text = userabout
        }
      
        //Show distance.......
        if (user_Data["lat"] != nil){
            let lat = user_Data["lat"] as! String
            if (user_Data["lng"] != nil){
                  let lng = user_Data["lng"] as! String
                if (lat != "empty" && lng != "empty" && !lat.isEmpty && !lng.isEmpty){
                    let user_lat = Double(lat) as! Double
                    let user_lng = Double(lng) as! Double
                    let distance_str = GetDistance(lat: user_lat, lng: user_lng)
                    self.distance_lbl.text = distance_str + "km away"
                }else {
                    self.distance_lbl.text = ""
                }
                
            }
        }
        
        
        ///************************
        let country = user_Data["land"] as! String ?? ""
        let city = user_Data["city"] as! String ?? ""
        if (!country.isEmpty){
            self.user_addressheight1.constant = 15
            self.user_addressheight1.constant = 15
            let country_count = AppData.shared.countries.count
            
            
            if (!city.isEmpty && city != "None selected") {
                var country_str: String = ""
                for index in 0..<country_count {
                    let country = AppData.shared.countries[index] as! NSDictionary
                    let country_names = country["Code"] as! String
                    let country_data = country["cities"] as! NSArray
                    let city_count = country_data.count
                    for j in 0..<city_count {
                        let city_data = country_data[j] as! NSDictionary
                        let city_name = city_data["name"] as! String
                        print(city_name)
                        if (city == city_name){
                            country_str = country_names
                        }
                        
                    }
                }
                
                self.user_Addresslbl.text = city + ", " + country_str
            }else{
                self.user_Addresslbl.text = country
            }
        }else{
            self.user_addressheight1.constant = 0
            self.user_addressheight1.constant = 0
            self.subview_height.constant = self.subview_height.constant - 15
        }
        if let orientation = user_Data["orientation"] as? NSNull {
            self.user_orientationheight1.constant = 0
            self.user_orientationheight2.constant = 0
            self.subview_height.constant = self.subview_height.constant - 15
        }else{
            let orientation = user_Data["orientation"] as! String ?? ""
            if (!orientation.isEmpty && orientation != "None selected"){
                self.user_orientationheight1.constant = 15
                self.user_orientationheight2.constant = 15
                self.user_OrientationLbl.text = orientation
            }else{
                self.user_orientationheight1.constant = 0
                self.user_orientationheight2.constant = 0
                self.subview_height.constant = self.subview_height.constant - 15
            }
        }
       
        if let purposeofdating = user_Data["purpose_of_dating"] as? NSNull {
            self.user_iamhereheight1.constant = 0
            self.user_iamhereheight2.constant = 0
            self.subview_height.constant = self.subview_height.constant - 15
        }else{
            let purposeofdating = user_Data["purpose_of_dating"] as! String ?? ""
            if (!purposeofdating.isEmpty && purposeofdating != "None selected"){
                self.user_iamhereheight1.constant = 15
                self.user_iamhereheight2.constant = 15
                self.user_IamhereLbl.text = purposeofdating
            }else{
                self.user_iamhereheight1.constant = 0
                self.user_iamhereheight2.constant = 0
                self.subview_height.constant = self.subview_height.constant - 15
            }
        }
    
        if let children = user_Data["children"] as? NSNull {
            self.user_childrenheight1.constant = 0
            self.user_childrenheight2.constant = 0
            self.subview_height.constant = self.subview_height.constant - 15
        }else{
            let children = user_Data["children"] as! String ?? ""
            if (!children.isEmpty && children != "undefined" && children != "None selected"){
                self.user_childrenheight1.constant = 15
                self.user_childrenheight2.constant = 15
                self.user_ChildrenLbl.text = children
            }else{
                self.user_childrenheight1.constant = 0
                self.user_childrenheight2.constant = 0
                self.subview_height.constant = self.subview_height.constant - 15
            }
        }
        
        if let relationship = user_Data["relationship"] as? NSNull {
            self.user_relationshipheight1.constant = 0
            self.user_relationshipheight2.constant = 0
            self.subview_height.constant = self.subview_height.constant - 15
        }else{
            let relationship = user_Data["relationship"] as?  String ?? ""
            if (!relationship.isEmpty && relationship != "None selected"){
                self.user_relationshipheight1.constant = 15
                self.user_relationshipheight2.constant = 15
                self.user_RelationshipStatusLbl.text = relationship
            }else{
                self.user_relationshipheight1.constant = 0
                self.user_relationshipheight2.constant = 0
                self.subview_height.constant = self.subview_height.constant - 15
            }
        }
        if let languages = user_Data["languages"] as? NSNull {
            self.user_languageheight1.constant = 0
            self.user_languageheight2.constant = 0
            self.subview_height.constant = self.subview_height.constant - 15
        }else{
            let languages = user_Data["languages"] as! String ?? ""
            if (!languages.isEmpty && languages != "None selected" && languages != "empty"){
                self.user_languageheight1.constant = 15
                self.user_languageheight2.constant = 15
                self.user_LanguagesLbl.text = languages
            }else{
                self.user_languageheight1.constant = 0
                self.user_languageheight2.constant = 0
                self.subview_height.constant = self.subview_height.constant - 15
            }
        }
        
        print(user_Data["growth"])
        print(user_Data["weight"])
        if (user_Data["growth"] != nil) {
            if let growth = user_Data["growth"] as? NSNull {
                self.user_growthheight1.constant = 0
                self.user_growthheight2.constant = 0
                self.subview_height.constant = self.subview_height.constant - 15
            }else{
                let growth = user_Data["growth"] as? String
                self.user_growthheight1.constant = 15
                self.user_growthheight2.constant = 15
                self.user_GrowthLbl.text = growth
            }
        }else{
            self.user_growthheight1.constant = 0
            self.user_growthheight2.constant = 0
            self.subview_height.constant = self.subview_height.constant - 15
        }
        if (user_Data["weight"] != nil) {
            
            if let weight = user_Data["weight"] as? NSNull {
                self.user_weightheight1.constant = 0
                self.user_weightheight2.constant = 0
                self.subview_height.constant = self.subview_height.constant - 15
            }else{
                let weight = user_Data["weight"] as! Int
                let weight_str = String(weight) as! String
                self.user_WeightLbl.text = weight_str
                self.user_weightheight1.constant = 15
                self.user_weightheight2.constant = 15
                
            }
        }else{
            self.user_weightheight1.constant = 0
            self.user_weightheight2.constant = 0
            self.subview_height.constant = self.subview_height.constant - 15
        }
        if (user_Data["ethnos"] != nil) {
            if let ethnos = user_Data["ethnos"] as? NSNull {
                self.user_ethnosheight1.constant = 0
                self.user_ethnosheight2.constant = 0
                self.subview_height.constant = self.subview_height.constant - 15
            }else{
                let ethnos = user_Data["ethnos"] as! String ?? ""
                if (!ethnos.isEmpty && ethnos != "None selected"){
                    self.user_ethnosheight1.constant = 15
                    self.user_ethnosheight2.constant = 15
                    self.user_EthnosLbl.text = ethnos
                }else{
                    self.user_ethnosheight1.constant = 0
                    self.user_ethnosheight2.constant = 0
                    self.subview_height.constant = self.subview_height.constant - 15
                }
            }
        }else{
            self.user_ethnosheight1.constant = 0
            self.user_ethnosheight2.constant = 0
            self.subview_height.constant = self.subview_height.constant - 15
        }
        if (user_Data["religion"] != nil) {
            if let worldview = user_Data["religion"] as? NSNull {
                self.user_worldviewheight1.constant = 0
                self.user_worldviewheight2.constant = 0
                self.subview_height.constant = self.subview_height.constant - 15
            }else{
                let worldview = user_Data["religion"] as! String ?? ""
                if (!worldview.isEmpty && worldview != "None selected"){
                    self.user_worldviewheight1.constant = 15
                    self.user_worldviewheight2.constant = 15
                    self.user_WorldviewLbl.text = worldview
                }else{
                    self.user_worldviewheight1.constant = 0
                    self.user_worldviewheight2.constant = 0
                    self.subview_height.constant = self.subview_height.constant - 15
                }
            }
            
        }else{
            self.user_worldviewheight1.constant = 0
            self.user_worldviewheight2.constant = 0
            self.subview_height.constant = self.subview_height.constant - 15
        }
        
        if (user_Data["political_view"] != nil) {
            if let political_view = user_Data["political_view"] as? NSNull {
                self.user_politicalviewheight1.constant = 0
                self.user_politicalviewheight2.constant = 0
                self.subview_height.constant = self.subview_height.constant - 15
            }else{
                let political_view = user_Data["political_view"] as! String ?? ""
                if (!political_view.isEmpty && political_view != "None selected"){
                    self.user_politicalviewheight1.constant = 15
                    self.user_politicalviewheight2.constant = 15
                    self.user_PoliticalViewLbl.text = political_view
                }else{
                    self.user_politicalviewheight1.constant = 0
                    self.user_politicalviewheight2.constant = 0
                    self.subview_height.constant = self.subview_height.constant - 15
                }
            }
            
        }else{
            self.user_politicalviewheight1.constant = 0
            self.user_politicalviewheight2.constant = 0
            self.subview_height.constant = self.subview_height.constant - 15
        }
        if (user_Data["personal_priority"] != nil) {
           
            if let personal_priority = user_Data["personal_priority"]  as? NSNull {
                self.user_personalpriorityheight1.constant = 0
                self.user_personalpriorityheight2.constant = 0
                self.subview_height.constant = self.subview_height.constant - 15
            }else{
                let personal_priority = user_Data["personal_priority"] as! String ?? ""
                if (!personal_priority.isEmpty && personal_priority != "Not specified"){
                    self.user_personalpriorityheight1.constant = 15
                    self.user_personalpriorityheight2.constant = 15
                    self.user_PersonalpriorityLbl.text = personal_priority
                }else{
                    self.user_personalpriorityheight1.constant = 0
                    self.user_personalpriorityheight2.constant = 0
                    self.subview_height.constant = self.subview_height.constant - 15
                }
            }
            
        }else{
            self.user_personalpriorityheight1.constant = 0
            self.user_personalpriorityheight2.constant = 0
            self.subview_height.constant = self.subview_height.constant - 15
        }
        if (user_Data["important_in_others"] != nil) {
           
            if let important_in_others = user_Data["important_in_others"]  as? NSNull {
                self.user_importantinotherheight1.constant = 0
                self.user_importantinotherheight2.constant = 0
                self.subview_height.constant = self.subview_height.constant - 15
            }else{
                let important_in_others = user_Data["important_in_others"] as! String ?? ""
                if (!important_in_others.isEmpty && important_in_others != "Not specified"){
                    self.user_importantinotherheight1.constant = 15
                    self.user_importantinotherheight2.constant = 15
                    self.user_ImportantinothersLbl.text = important_in_others
                }else{
                    self.user_importantinotherheight1.constant = 0
                    self.user_importantinotherheight2.constant = 0
                    self.subview_height.constant = self.subview_height.constant - 15
                }
            }
            
        }else{
            self.user_importantinotherheight1.constant = 0
            self.user_importantinotherheight2.constant = 0
            self.subview_height.constant = self.subview_height.constant - 15
        }
        if (user_Data["views_on_smoking"] != nil) {
           
            if let views_on_smoking = user_Data["views_on_smoking"] as? NSNull {
                self.user_viewonsmokingheight1.constant = 0
                self.user_viewonsmokingheight2.constant = 0
                self.subview_height.constant = self.subview_height.constant - 15
            }else{
                let views_on_smoking = user_Data["views_on_smoking"] as! String ?? ""
                if (!views_on_smoking.isEmpty && views_on_smoking != "Not specified"){
                    self.user_viewonsmokingheight1.constant = 15
                    self.user_viewonsmokingheight2.constant = 15
                    self.user_ViewsonSmokingLbl.text = views_on_smoking
                }else{
                    self.user_viewonsmokingheight1.constant = 0
                    self.user_viewonsmokingheight2.constant = 0
                    self.subview_height.constant = self.subview_height.constant - 15
                }
            }
        }else{
            self.user_viewonsmokingheight1.constant = 0
            self.user_viewonsmokingheight2.constant = 0
            self.subview_height.constant = self.subview_height.constant - 15
        }
        if (user_Data["views_on_alcohol"] != nil) {
            
            if let views_on_alcohol = user_Data["views_on_alcohol"] as? NSNull {
                self.user_viewonalcholheight1.constant = 0
                self.user_viewonalcholheight2.constant = 0
                self.subview_height.constant = self.subview_height.constant - 15
            }else{
                let views_on_alcohol = user_Data["views_on_alcohol"] as! String ?? ""
                if (!views_on_alcohol.isEmpty && views_on_alcohol != "Not specified"){
                    self.user_viewonalcholheight1.constant = 15
                    self.user_viewonalcholheight2.constant = 15
                    self.user_ViewsonAlcholLbl.text = views_on_alcohol
                }else{
                    self.user_viewonalcholheight1.constant = 0
                    self.user_viewonalcholheight2.constant = 0
                    self.subview_height.constant = self.subview_height.constant - 15
                }
            }
        }else{
            self.user_viewonalcholheight1.constant = 0
            self.user_viewonalcholheight2.constant = 0
            self.subview_height.constant = self.subview_height.constant - 15
        }
        if (user_Data["profession"] != nil) {
            
            if let profession = user_Data["profession"] as? NSNull {
                self.user_professionheight1.constant = 0
                self.user_professionheight2.constant = 0
                self.subview_height.constant = self.subview_height.constant - 15
            }else{
                let profession = user_Data["profession"] as! String ?? ""
                if (!profession.isEmpty && profession != "Not specified" && profession != "None selected"){
                    self.user_professionheight1.constant = 15
                    self.user_professionheight2.constant = 15
                    self.user_ProfessionLbl.text = profession
                }else{
                    self.user_professionheight1.constant = 0
                    self.user_professionheight2.constant = 0
                    self.subview_height.constant = self.subview_height.constant - 15
                }
            }
            
        }else{
            self.user_professionheight1.constant = 0
            self.user_professionheight2.constant = 0
            self.subview_height.constant = self.subview_height.constant - 15
        }
        if (user_Data["place_of_work"] != nil) {
            if let place_of_work = user_Data["place_of_work"] as? NSNull {
                self.user_placeofworkheight1.constant = 0
                self.user_placeofworkheight2.constant = 0
                self.subview_height.constant = self.subview_height.constant - 15
            }else{
                let place_of_work = user_Data["place_of_work"] as! String ?? ""
                if (!place_of_work.isEmpty && place_of_work != "empty"){
                    self.user_placeofworkheight1.constant = 15
                    self.user_placeofworkheight2.constant = 15
                    self.user_PlaceofworkLbl.text = place_of_work
                }else{
                    self.user_placeofworkheight1.constant = 0
                    self.user_placeofworkheight2.constant = 0
                    self.subview_height.constant = self.subview_height.constant - 15
                }
            }
        }else{
            self.user_placeofworkheight1.constant = 0
            self.user_placeofworkheight2.constant = 0
            self.subview_height.constant = self.subview_height.constant - 15
        }
        
        
        ///.//////////Finish User Info/////////
        //User Photo Slider part......
        let photoDatas = self.UserData["photos"] as! NSArray
        self.photoData = self.UserData["photos"] as! NSArray
        if (photoDatas.count > 0){
            for index in 0..<photoDatas.count {
                let each_photo = photoDatas[index] as! NSDictionary
                let avatarImage = each_photo["photo"] as! String
                self.user_photoslider.auk.show(url: photoUrl(avatar: avatarImage))
            }
            let height = (self.user_photoView.frame.width - 25) / 3
            if (photoDatas.count % 3 == 0){
                self.photo_height.constant = height * CGFloat(photoDatas.count / 3 as! Int)
                if (self.photo_height.constant > 168){
                    self.subview_height.constant = self.subview_height.constant + self.photo_height.constant - 168
                }else {
                     self.subview_height.constant = self.subview_height.constant + self.photo_height.constant - 168
                }
            }else {
                self.photo_height.constant = height * CGFloat(photoDatas.count / 3 as! Int + 1)
                if (self.photo_height.constant > 168){
                    self.subview_height.constant = self.subview_height.constant + self.photo_height.constant - 168
                }else {
                    self.subview_height.constant = self.subview_height.constant + self.photo_height.constant - 168
                }
            }
        }else{
            self.photo_height.constant = 0
            self.subview_height.constant = self.subview_height.constant - 168
        }
        if (user_Data["interests"] != nil) {
            let interestData = user_Data["interests"] as! String
            self.interestArray = interestData.components(separatedBy: ",")
        }
        if (self.interestArray.count > 0){
            if (self.interestArray.count % 3 == 0){
                self.interestView_height.constant = 38 * CGFloat(self.interestArray.count / 3)
                self.subview_height.constant = self.subview_height.constant + self.interestView_height.constant - 73
            }else{
                self.interestView_height.constant = 38 * CGFloat(self.interestArray.count / 3 + 1)
                self.subview_height.constant = self.subview_height.constant + self.interestView_height.constant - 73
            }
        }else{
            self.interestView_height.constant = 0
            self.subview_height.constant = self.subview_height.constant - 73
        }
        
        user_photoView.delegate = self
        user_photoView.dataSource = self
        self.user_InterestView.delegate = self
        self.user_InterestView.dataSource = self
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
  
}
extension DetailVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.user_photoView){
            return self.photoData.count
        }else{
            return self.interestArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.user_photoView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as! DetailCell
            let each_photo =  self.photoData[indexPath.row] as! NSDictionary
            let each_photourl = each_photo["photo_min"] as! String
            cell.user_photo.moa.url = photoUrl(avatar: each_photourl)
            cell.user_photo.moa.errorImage = UIImage(named: "default_avatar")
            return cell
        }else{
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailinterestCell", for: indexPath) as! DetailInterestCell
              cell.interest_item.text = self.interestArray[indexPath.row]
             return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension DetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == self.user_photoView){
            let bounds = collectionView.bounds
            return CGSize(width: (bounds.width - 25) / 3, height: (bounds.width - 25) / 3)
        }else{
            let bounds = collectionView.bounds
            return CGSize(width: (bounds.width - 25) / 3, height: 30)
        }
        
    }
}

