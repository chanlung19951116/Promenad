//
//  SearchVC.swift
//  Promenad
//
//  Created by LiuYan on 8/2/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces
import TTRangeSlider
class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String = ""
    var distance : String = ""
}
class SearchVC: UIViewController, GMSMapViewDelegate{

    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: GMSMapView!
    var sortData = NSMutableDictionary()
    
    
    @IBOutlet weak var sort_popular: UILabel!
    
    @IBOutlet weak var sort_nearby: UILabel!
    
    @IBOutlet weak var sort_subscriber: UILabel!
    
    @IBOutlet weak var search_love: CardView!
     @IBOutlet weak var search_chat: CardView!
     @IBOutlet weak var search_sex: CardView!
     @IBOutlet weak var search_smile: CardView!
     @IBOutlet weak var search_plane: CardView!
    
    @IBOutlet weak var search_loveimage: UIImageView!
    @IBOutlet weak var search_chatimage: UIImageView!
    @IBOutlet weak var search_seximage: UIImageView!
    @IBOutlet weak var search_smileimage: UIImageView!
    @IBOutlet weak var search_planeimage: UIImageView!
    
    @IBOutlet weak var Searchage_range: TTRangeSlider!
    
    @IBOutlet weak var find_people: CardView!
    
    @IBOutlet weak var ser: CardView!
    
    @IBOutlet weak var searchsubView: UIView!
    var searchtype : String = ""
    var purposeString : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
       
        
        // Do any additional setup after loading the view.
    }
    func initUI(){
        self.mapView.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        let leafimage = UIImage(named: "ic_search")!
        let notificationimage = UIImage(named: "notification")!
        
        let leafBtn: UIButton = UIButton(type: UIButton.ButtonType.custom) as! UIButton
        leafBtn.setImage(leafimage, for: .normal)
        leafBtn.addTarget(self, action: #selector(Search), for: .touchUpInside)
        leafBtn.frame = CGRect(origin : CGPoint(x:-10, y:0), size: CGSize(width: 20, height: 30))
        let leafbaritem = UIBarButtonItem(customView: leafBtn)
        
        let noti_btn: UIButton = UIButton(type: UIButton.ButtonType.custom) as! UIButton
        noti_btn.setImage(notificationimage, for: .normal)
        noti_btn.addTarget(self, action: #selector(Notification), for: .touchUpInside)
        noti_btn.frame = CGRect(origin : CGPoint(x:-10, y:0), size: CGSize(width: 20, height: 30))
        let notiBtn = UIBarButtonItem(customView: noti_btn)
        self.navigationItem.setRightBarButtonItems([notiBtn], animated: false)
        self.navigationItem.setLeftBarButtonItems([leafbaritem], animated: false)
        
        let logo_image = UIImage(named: "logo_small")
        let imageView = UIImageView(image:logo_image)
        navigationItem.titleView = imageView
       //Sort Type
        let sort_populargesture = UITapGestureRecognizer(target:self,action:#selector(self.Sort_Popular))
        let sort_nearbygesture = UITapGestureRecognizer(target:self,action:#selector(self.Sort_Nearby))
        let sort_subscribegesture = UITapGestureRecognizer(target:self,action:#selector(self.Sort_Subscribe))
        self.sort_popular.isUserInteractionEnabled = true
        self.sort_nearby.isUserInteractionEnabled = true
        self.sort_subscriber.isUserInteractionEnabled = true
        self.sort_popular.addGestureRecognizer(sort_populargesture)
        self.sort_nearby.addGestureRecognizer(sort_nearbygesture)
        self.sort_subscriber.addGestureRecognizer(sort_subscribegesture)
        
        //Purpose of Dating
         let purpose_lovegesture = UITapGestureRecognizer(target:self,action:#selector(self.purpose_of_love))
         let purpose_chatgesture = UITapGestureRecognizer(target:self,action:#selector(self.purpose_of_chat))
         let purpose_sexgesture = UITapGestureRecognizer(target:self,action:#selector(self.purpose_of_sex))
         let purpose_smilegesture = UITapGestureRecognizer(target:self,action:#selector(self.purpose_of_smile))
         let purpose_planegesture = UITapGestureRecognizer(target:self,action:#selector(self.purpose_of_plane))
         self.search_love.addGestureRecognizer(purpose_lovegesture)
         self.search_chat.addGestureRecognizer(purpose_chatgesture)
         self.search_sex.addGestureRecognizer(purpose_sexgesture)
         self.search_smile.addGestureRecognizer(purpose_smilegesture)
         self.search_plane.addGestureRecognizer(purpose_planegesture)
        
         let find_gesture = UITapGestureRecognizer(target:self,action:#selector(self.FindPeople))
         self.find_people.addGestureRecognizer(find_gesture)
        
        self.ser.isHidden = true
        self.searchsubView.isHidden = true
        self.ShowMyLocation()
    }
    @objc func FindPeople(){
        if (self.searchtype == "Nearby"){
            self.ser.isHidden = true
            self.searchsubView.isHidden = true
            self.LoadNearyByUsers()
        }else if (self.searchtype == "Popular"){
            let lowervalue = self.Searchage_range.selectedMinimum as! Float
            let uppervalue = self.Searchage_range.selectedMaximum as! Float
            let lower_age = Int(lowervalue) as! Int
            let upper_age = Int(uppervalue) as! Int
            let lower_agestr = String(lower_age) as! String
            let upper_agestr = String(upper_age) as! String
            let age_str = lower_agestr + "," + upper_agestr
            self.PopularSearch(age: age_str, purpose: self.purposeString)
        }
    }
    @objc func Sort_Popular(){
        let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        self.sort_popular.textColor = bgselect_color
        self.sort_nearby.textColor = UIColor.lightGray
        self.sort_subscriber.textColor = UIColor.lightGray
        self.searchtype = "Popular"
    }
    @objc func Sort_Nearby(){
        let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        self.sort_popular.textColor = UIColor.lightGray
        self.sort_nearby.textColor = bgselect_color
        self.sort_subscriber.textColor = UIColor.lightGray
        self.searchtype = "Nearby"
    }
    @objc func Sort_Subscribe(){
        let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        self.sort_popular.textColor = UIColor.lightGray
        self.sort_nearby.textColor = UIColor.lightGray
        self.sort_subscriber.textColor = bgselect_color
        self.searchtype = "Sub"
    }
    @objc func purpose_of_love(){
        self.search_loveimage.image = UIImage(named: "search_love")
        self.search_chatimage.image = UIImage(named: "search_unchat")
        self.search_seximage.image = UIImage(named: "search_unsex")
        self.search_smileimage.image = UIImage(named: "search_unsmile")
        self.search_planeimage.image = UIImage(named: "search_unplane")
        self.purposeString = "Serious relationship"
    }
    @objc func purpose_of_chat(){
        self.search_loveimage.image = UIImage(named: "search_unlove")
        self.search_chatimage.image = UIImage(named: "search_chat")
        self.search_seximage.image = UIImage(named: "search_unsex")
        self.search_smileimage.image = UIImage(named: "search_unsmile")
        self.search_planeimage.image = UIImage(named: "search_unplane")
        self.purposeString = "Friendship"
    }
    @objc func purpose_of_sex(){
        self.search_loveimage.image = UIImage(named: "search_unlove")
        self.search_chatimage.image = UIImage(named: "search_unchat")
        self.search_seximage.image = UIImage(named: "search_sex")
        self.search_smileimage.image = UIImage(named: "search_unsmile")
        self.search_planeimage.image = UIImage(named: "search_unplane")
        self.purposeString = "Sex"
    }
    @objc func purpose_of_smile(){
        self.search_loveimage.image = UIImage(named: "search_unlove")
        self.search_chatimage.image = UIImage(named: "search_unchat")
        self.search_seximage.image = UIImage(named: "search_unsex")
        self.search_smileimage.image = UIImage(named: "search_smile")
        self.search_planeimage.image = UIImage(named: "search_unplane")
        self.purposeString = "Flirt"
    }
    @objc func purpose_of_plane(){
        self.search_loveimage.image = UIImage(named: "search_unlove")
        self.search_chatimage.image = UIImage(named: "search_unchat")
        self.search_seximage.image = UIImage(named: "search_unsex")
        self.search_smileimage.image = UIImage(named: "search_unsmile")
        self.search_planeimage.image = UIImage(named: "search_plane")
        self.purposeString = "Travels"
    }
    
    
    
    func ShowMyLocation(){
        let camera = GMSCameraPosition.camera(withLatitude: AppData.shared.my_lat,
                                              longitude: AppData.shared.my_lng,
                                              zoom: 14)
        self.mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: AppData.shared.my_lat, longitude: AppData.shared.my_lng)
        let markerView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        markerView.layer.cornerRadius = 20
        markerView.layer.masksToBounds = true
        markerView.layer.borderColor = UIColor.blue.cgColor
        markerView.layer.borderWidth = 3
        if let imagesource = AppData.shared.UserData["min_avatar"] as? NSNull {
            let imageurl = AppData.shared.UserData["avatar"] as! String
            markerView.moa.url = photoUrl(avatar: imageurl)
            marker.iconView = markerView
        }else{
            if (AppData.shared.UserData["min_avatar"] != nil){
                let imageDataString = AppData.shared.UserData["min_avatar"] as! String
                let imageString = imageDataString.components(separatedBy: ",")
                let encodedString = imageString[1]
                let imageData = Data(base64Encoded: encodedString, options: .ignoreUnknownCharacters)!
                let decodeimage: UIImage = UIImage(data: imageData)!
                markerView.image = decodeimage
               
            }
        }
        let user_id = AppData.shared.UserData["id"] as! Int
        marker.userData = user_id
        marker.iconView = markerView
        marker.map = self.mapView
        
        
    }
    @objc func Search(){
        if (self.searchsubView.isHidden){
            self.searchsubView.isHidden = false
            self.ser.isHidden = false
        }else{
            self.searchsubView.isHidden = true
            self.ser.isHidden = true
            
        }
    }
    @objc func Notification(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "assistantVC") as! AssistantVC
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.LoadNearyByUsers()
    }
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("click")
    }
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("click")
        let id = marker.userData as! Int
        let userid = AppData.shared.UserData["id"] as! Int
        if (id != userid) {
            let user_id = String(id) as! String
            self.LoadOtherUserData(user_id: user_id)
        }
        
        return true
    }
   
}
extension SearchVC: CLLocationManagerDelegate {
    // 2
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4
        locationManager.startUpdatingLocation()
        
        //5
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    // 6
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        // 7
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        // 8
        locationManager.stopUpdatingLocation()
    }
}
extension SearchVC {
    func LoadNearyByUsers(){
        AppData.shared.showLoadingIndicator(view: self.view)
        UserLocationService().NearByUsers(age: "", purpose: ""){ (response) in
            if let json = response {
                AppData.shared.hideLoadingIndicator()
                do {
                    let NearUsers = json as! NSArray
                    if (NearUsers.count > 0){
                        
                       // print(alpha_radian)
                        var alpha: Double = 0
                        var distance: Double = 0
                        var range: Int = 2
                        for index in 0..<NearUsers.count {
                            let markerdata = NearUsers[index] as! NSDictionary
                            if (index == 0){
                                distance = markerdata["distance"] as! Double
                            }
                           
                            if (index % 12 < 6){
                                let alpha_radian = 2 * Double.pi / 6
                                
                                let imageDataString = markerdata["min_avatar"] as! String
                                let imageString = imageDataString.components(separatedBy: ",")
                                let encodedString = imageString[1]
                                let imageData = Data(base64Encoded: encodedString, options: .ignoreUnknownCharacters)!
                                let decodeimage: UIImage = UIImage(data: imageData)!
                                
                                let sub_distance = distance * Double(range)
                                
                                let result_latlng = GetLatitudeandLongitude(distance: sub_distance, alpha: alpha)
                                let lat_angle = result_latlng["lat"] as! Double
                                let lng_angle = result_latlng["lng"] as! Double
                                let marker = GMSMarker()
                                marker.position = CLLocationCoordinate2D(latitude: lat_angle, longitude: lng_angle)
                                let markerView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
                                markerView.layer.cornerRadius = 30
                                markerView.layer.masksToBounds = true
                                markerView.layer.borderColor = UIColor.white.cgColor
                                markerView.layer.borderWidth = 3
                                markerView.image = decodeimage
                                marker.iconView = markerView
                                let id = markerdata["id"] as! Int
                                marker.userData = id
                                marker.map = self.mapView
                                alpha = alpha + alpha_radian
                                if (index % 12 == 5){
                                    alpha = 0
                                    range = range + 2
                                    
                                }
                            }else if (index % 12 > 5) {
                                let alpha_radian = 2 * Double.pi / 6
                                let imageDataString = markerdata["min_avatar"] as! String
                                let imageString = imageDataString.components(separatedBy: ",")
                                let encodedString = imageString[1]
                                let imageData = Data(base64Encoded: encodedString, options: .ignoreUnknownCharacters)!
                                let decodeimage: UIImage = UIImage(data: imageData)!
                                let sub_distance = distance * Double(range)
                                let result_latlng = GetLatitudeandLongitude(distance: sub_distance, alpha: alpha)
                                let lat_angle = result_latlng["lat"] as! Double
                                let lng_angle = result_latlng["lng"] as! Double
                                let marker = GMSMarker()
                                marker.position = CLLocationCoordinate2D(latitude: lat_angle, longitude: lng_angle)
                                let markerView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
                                markerView.layer.cornerRadius = 20
                                markerView.layer.masksToBounds = true
                                markerView.layer.borderColor = UIColor.white.cgColor
                                markerView.layer.borderWidth = 3
                                markerView.image = decodeimage
                                marker.iconView = markerView
                                let id = markerdata["id"] as! Int
                                marker.userData = id
                                marker.map = self.mapView
                                alpha = alpha + alpha_radian
                                if (index % 12 == 11){
                                    alpha = 0
                                    range = range + 2
                                }
                            }
                        }
                        let location = CLLocation(latitude: AppData.shared.my_lat, longitude: AppData.shared.my_lng)
                        self.mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 11.5 , bearing: 0, viewingAngle: 0)
                    }
                   //print(NearUsers)
                }catch(let error){
                    
                }
            }else{
                 AppData.shared.hideLoadingIndicator()
            }
        }
    }
    func PopularSearch(age: String , purpose:String){
        AppData.shared.showLoadingIndicator(view: self.view)
        UserLocationService().NearByUsers(age: "", purpose: ""){ (response) in
            if let json = response {
                AppData.shared.hideLoadingIndicator()
                do {
                    let NearUsers = json as! NSArray
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "popularVC") as! PopularSearchVC
                    // self.present(verificationController, animated: true, completion: nil)
                    vc.UsersData = NearUsers
                    self.navigationController?.pushViewController(vc, animated: true)
                }catch(let error){
                   
                }
            }else {
                AppData.shared.hideLoadingIndicator()
            }
        }
        
    }
}
extension SearchVC {
    func LoadOtherUserData(user_id: String){
        LoadUsersService().LoadOtherUserData(userid: user_id){ (response) in
            if let json = response {
                do {
                    let resultData = json as! NSDictionary
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "detailVC") as! DetailVC
                    vc.UserData = resultData
                    // self.present(verificationController, animated: true, completion: nil)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                catch(let error){
                    AppData.shared.displayToastMessage("Cannot get user me, please try it later.")
                    
                }
            }else {
                AppData.shared.displayToastMessage("Cannot get user me, please try it later.")
            }
            
        }
        
    }
}
