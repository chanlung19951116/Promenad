//
//  SigninMainVC.swift
//  Promenad
//
//  Created by LiuYan on 7/30/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit
import UIGradient
import CoreLocation
class SigninMainVC: UIViewController,CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    @IBOutlet weak var signin_phonebtn: CardView!
    
    @IBOutlet weak var signin_emailbtn: CardView!
    
    @IBOutlet weak var signin_fbbtn: CardView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        GetUserLocation()
        // Do any additional setup after loading the view.
    }
    func initUI(){
        let startcolor = UIColor(red: 142/255, green: 199/255, blue: 249/255, alpha: 1.0)
        let endcolor = UIColor(red: 52/255, green: 80/255, blue: 253/255, alpha: 1.0)
        self.signin_phonebtn.backgroundColor = UIColor.fromGradientWithDirection(.topToBottom, frame: self.signin_phonebtn.frame, colors: [startcolor, endcolor])
        let sign_phonegesture = UITapGestureRecognizer(target:self,action:#selector(self.Signin_phone))
        signin_phonebtn.addGestureRecognizer(sign_phonegesture)
        let sign_emailgesture = UITapGestureRecognizer(target:self,action:#selector(self.Signin_Email))
        signin_emailbtn.addGestureRecognizer(sign_emailgesture)
    }
    @objc func Signin_phone(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "signupmbVC0") as! SignupMobileVC0
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func Signin_Email(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "signinemailVC") as! SigninEmailVC
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func GetUserLocation(){
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        self.locationManager = locationManager
        
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
            if let userLocation = locationManager.location?.coordinate {
                AppData.shared.my_lat = userLocation.latitude as! Double
                AppData.shared.my_lng = userLocation.longitude as! Double
                print(AppData.shared.my_lng)
            }
        }
    }
}
