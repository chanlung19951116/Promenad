//
//  UserProfilePhotoVC.swift
//  Promenad
//
//  Created by LiuYan on 8/1/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class UserProfilePhotoVC: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var back_btn: UIImageView!
    @IBOutlet weak var profile_imageView: UIImageView!
    
    @IBOutlet weak var select_image: UILabel!
    
    @IBOutlet weak var start_view: CardView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    func initUI(){
        let back_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Back_action))
        back_btn.addGestureRecognizer(back_gesture)
        back_btn.isUserInteractionEnabled = true
        let select_photogesture = UITapGestureRecognizer(target:self,action:#selector(self.SelectPhoto))
        select_image.addGestureRecognizer(select_photogesture)
        select_image.isUserInteractionEnabled = true
        let start_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Start_Dating))
        start_view.addGestureRecognizer(start_gesture)
    }
    @objc func Back_action(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    @objc func SelectPhoto(){
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    func openCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            // self.flag = 0
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You can't use the camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openPhotoLibrary() {
        //self.flag = 1
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            
            self.select_image.isHidden = true
            self.profile_imageView.image = image
            let resizeimage = self.resizeImage(image: image, targetSize: CGSize.init(width: 300, height: 300))
            let imageData = resizeimage.jpegData(compressionQuality: 0.9)!
            if (saveProfileImage(imageData: imageData) == true) {
                AppData.shared.userphotoFileName = "profile.jpg"
                AppData.shared.userImageString = ProfilePhotoFilePath()
                print("success")
            }
            //let data_string = self.saveImageToDocumentDirectory(resizeimage)
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    @objc func Start_Dating(){
        
        if (AppData.shared.userphotoFileName.isEmpty){
            AppData.shared.displayToastMessage("Please select avatar")
            return
        }
        AppData.shared.showLoadingIndicator(view: self.view)
        if (AppData.shared.verification_type == "email"){
            RegisterServic().Register_Email{ (response) in
                DispatchQueue.main.async {
                    
                    if let json = response {
                        do {
                            AppData.shared.hideLoadingIndicator()
                            let resultData = json as! NSDictionary
                            print(resultData)
                            let authToken = resultData["authToken"] as! String
                            if (authToken != "false") {
                                let authtoken = resultData["authToken"] as! String
                                AppData.shared.authToken = authtoken
                                UserDefaults.standard.set(AppData.shared.authToken, forKey: "auth_Token")
                                self.LoginInfo()
                            }else{
                                AppData.shared.displayToastMessage("error")
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
        }else{
            RegisterServic().Register_Phone{ (response) in
                DispatchQueue.main.async {
                    
                    if let json = response {
                        do {
                            AppData.shared.hideLoadingIndicator()
                            let resultData = json as! NSDictionary
                            print(resultData)
                            let authToken = resultData["authToken"] as! Bool
                            if (authToken != false) {
                                let authtoken = resultData["authToken"] as! String
                                AppData.shared.authToken = authtoken
                                UserDefaults.standard.set(AppData.shared.authToken, forKey: "auth_Token")
                                self.LoginInfo()
                            }else{
                                AppData.shared.displayToastMessage("error")
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
        
        
        
        
    }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
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
