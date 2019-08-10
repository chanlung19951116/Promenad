//
//  ProfileVC.swift
//  Promenad
//
//  Created by LiuYan on 8/3/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var edit_profileBtn: UILabel!
    @IBOutlet weak var edit_profileView: CardView!
    @IBOutlet weak var profile_imageView: UIImageView!
    @IBOutlet weak var user_nameAgelbl: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var assistant_lbl: UILabel!
    @IBOutlet weak var assistant_image: UIImageView!
    
    
    @IBOutlet weak var logout_Btn: UIButton!
    @IBOutlet weak var tapView: UICollectionView!
    var imageArray : [UIImage] = [UIImage(named: "ic_leaf")!,UIImage(named: "ic_match")!,UIImage(named: "ic_thumb")!,UIImage(named: "ic_love")!,UIImage(named: "ic_time")!,UIImage(named: "ic_account")!,UIImage(named: "ic_star")!,UIImage(named: "ic_hidden")!]
    var titleArray : [String] = ["BUY MORE","MATCHES","LIKED YOU","YOUR LIKES","YOU LOOKED","GUESTS","FAVOURITES","HIDDEN",]
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    @IBAction func Logout(_ sender: Any) {
        
    }
    func initUI(){
        self.profile_imageView.layer.cornerRadius = self.profile_imageView.frame.width / 2
        self.profile_imageView.layer.masksToBounds = true
        if (AppData.shared.UserData["min_avatar"] != nil){
            let imageDataString = AppData.shared.UserData["min_avatar"] as! String
            let imageString = imageDataString.components(separatedBy: ",")
            let encodedString = imageString[1]
            let imageData = Data(base64Encoded: encodedString, options: .ignoreUnknownCharacters)!
            let decodeimage: UIImage = UIImage(data: imageData)!
            self.profile_imageView.image = decodeimage
            
        }
        let userName = AppData.shared.UserData["name"] as! String
        let birthdate = AppData.shared.UserData["birth_date"] as! String
        let age = getAge(birthdate: birthdate)
        if (age == "-1"){
             self.user_nameAgelbl.text = userName
        }else{
             self.user_nameAgelbl.text = userName + ", " + age
        }
        let city = AppData.shared.UserData["city"] as! String ?? ""
        let country = AppData.shared.UserData["land"] as! String ?? ""
        if (!country.isEmpty) {
            if (!city.isEmpty){
                self.address.text = city + ", " + country
            }else{
                self.address.text = country
            }
        }else {
            self.address.text = ""
        }
        
        
        
        
        tapView.dataSource = self
        tapView.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        let leafimage = UIImage(named: "leaf")!
        let notificationimage = UIImage(named: "notification")!
        
        let leafBtn: UIButton = UIButton(type: UIButton.ButtonType.custom) as! UIButton
        leafBtn.setImage(leafimage, for: .normal)
        leafBtn.addTarget(self, action: #selector(Leaf_Action), for: .touchUpInside)
        leafBtn.frame = CGRect(origin : CGPoint(x:-10, y:0), size: CGSize(width: 20, height: 30))
        let leafbaritem = UIBarButtonItem(customView: leafBtn)
        
        let leaflabel = UILabel(frame: CGRect(x: 20, y: 0, width: 20, height: 30))
        leaflabel.text = "100"
        let text_color = UIColor.init(red: 70/255, green: 69/255, blue: 77/255, alpha: 1.0)
        leaflabel.textColor = text_color
        let leafbarseconditem = UIBarButtonItem(customView: leaflabel)
        
        
        let leaflabel1 = UILabel(frame: CGRect(x: 20, y: 0, width: 20, height: 30))
        let leafbarseconditem1 = UIBarButtonItem(customView: leaflabel1)
        
        let noti_btn: UIButton = UIButton(type: UIButton.ButtonType.custom) as! UIButton
        noti_btn.setImage(notificationimage, for: .normal)
        noti_btn.addTarget(self, action: #selector(Notification), for: .touchUpInside)
        noti_btn.frame = CGRect(origin : CGPoint(x:-10, y:0), size: CGSize(width: 20, height: 30))
        let notiBtn = UIBarButtonItem(customView: noti_btn)
        self.navigationItem.setRightBarButtonItems([notiBtn,leafbarseconditem1], animated: false)
        self.navigationItem.setLeftBarButtonItems([leafbaritem,leafbarseconditem], animated: false)
        
        
        
        let logo_image = UIImage(named: "logo_small")
        let imageView = UIImageView(image:logo_image)
        navigationItem.titleView = imageView
        //Edit Profile Gesture
        let profile_gesture = UITapGestureRecognizer(target:self,action:#selector(self.EditProfile))
        self.edit_profileView.addGestureRecognizer(profile_gesture)
    }
    @objc func EditProfile(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "editprofileVC") as! EditProfileVC
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func Leaf_Action(){
        let leafDialog = LeafDialog(title: "", vc: self)
        leafDialog.show(animated: true)
    }
    @objc func Notification(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "assistantVC") as! AssistantVC
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
extension ProfileVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCell
        cell.imageView.image = self.imageArray[indexPath.row]
        cell.title_lbl.text = self.titleArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            
            break
        case 1:
            self.LoadUserList(userType: "Matches")
            break
        case 2:
            self.LoadUserList(userType: "getLikesFromUsers")
            break
        case 3:
            self.LoadUserList(userType: "getLikedUsers")
            break
        case 4:
            self.LoadUserList(userType: "visitedUsers")
            break
        case 5:
            self.LoadUserList(userType: "visitors")
            break
        case 6:
            self.LoadUserList(userType: "favourites")
            break
        case 7:
            self.LoadUserList(userType: "black")
            break
        default:
            self.LoadUserList(userType: "black")
            break
        }
    }
    
}

extension ProfileVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        return CGSize(width: (bounds.width - 10) / 2, height: 80)
    }
}
extension ProfileVC {
    
    func LoadUserList(userType: String){
        AppData.shared.showLoadingIndicator(view: self.view)
        if (userType == "Matches") {
            LoadUsersService().MatchUserList{ (response) in
                if let json = response {
                    do {
                        AppData.shared.hideLoadingIndicator()
                        let resultData = json as! NSDictionary
                        let UserData = resultData["matches"] as! NSArray
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "userlistVC") as! UserListVC
                        vc.UsersData = UserData
                        vc.UserType = userType
                            // self.present(verificationController, animated: true, completion: nil)
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                    catch(let error){
                        AppData.shared.hideLoadingIndicator()
                    }
                }
                else {
                   // AppData.shared.displayToastMessage("Cannot get user me, please try it later.")
                    print("Response was nil")
                }
            }
        }else{
            LoadUsersService().LoadUserList(tagUrl: userType) { (response) in
                if let json = response {
                    do {
                        AppData.shared.hideLoadingIndicator()
                        let resultData = json as! NSArray
                       
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "userlistVC") as! UserListVC
                        vc.UsersData = resultData
                        vc.UserType = userType
                        if (userType == "black") {
                            vc.blockuser = true
                        }else{
                            vc.blockuser = false
                        }
                        // self.present(verificationController, animated: true, completion: nil)
                        self.navigationController?.pushViewController(vc, animated: true)
                    
                    }
                    catch(let error){
                        AppData.shared.hideLoadingIndicator()
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

