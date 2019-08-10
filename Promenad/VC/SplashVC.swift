//
//  SplashVC.swift
//  Promenad
//
//  Created by LiuYan on 7/28/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import CoreLocation
class SplashVC: UIViewController,CLLocationManagerDelegate  {
   
    var locationManager = CLLocationManager()
    @IBOutlet weak var indicator: NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.indicator.startAnimating()
        let countries = AppData.shared.readJSONFromFile(fileName: "location") as! NSDictionary
        let array = countries["countries"] as! NSArray
        AppData.shared.countries = array 
       // print(array)
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.indicator.stopAnimating()
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "boardVC") as! BoardVC
            // self.present(verificationController, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
      
        self.GetUserLocation()
       // print(AppData.shared.userHeight)
       
       // let angle = sin(Double.pi / 2)
        
      
       
        
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
                //print(AppData.shared.my_lng)
            }
        }
    }
    
}
