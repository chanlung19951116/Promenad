//
//  UserListVC.swift
//  Promenad
//
//  Created by LiuYan on 8/7/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class UserListVC: UIViewController {

    
    
    @IBOutlet weak var users_title: UILabel!
    
    @IBOutlet weak var userlistView: UITableView!
    var UsersData = NSArray()
    var UserType: String = ""
    var blockuser: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    func initUI(){
        userlistView.dataSource = self
        userlistView.delegate = self
        if (UserType == "Matches") {
             users_title.text = UserType
        }else if (UserType == "getLikesFromUsers") {
            users_title.text = "Liked You"
        }else if (UserType == "getLikedUsers") {
            users_title.text = "Your Likes"
        }else if (UserType == "visitedUsers") {
            users_title.text = "You looked"
        }else if (UserType == "visitors") {
            users_title.text = "Guests"
        }else if (UserType == "favourites") {
            users_title.text = "Favourites"
        }else if (UserType == "black") {
            users_title.text = "Hidden"
        }
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        let leafimage = UIImage(named: "back")!
        let notificationimage = UIImage(named: "notification")!
        
        let leafBtn: UIButton = UIButton(type: UIButton.ButtonType.custom) as! UIButton
        leafBtn.setImage(leafimage, for: .normal)
        leafBtn.addTarget(self, action: #selector(Leaf_Action), for: .touchUpInside)
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
    }
    @objc func Leaf_Action(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    @objc func Notification(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "assistantVC") as! AssistantVC
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = false
    }
}
extension UserListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return  self.UsersData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userlistCell", for: indexPath) as! UserlistCell
        let userData = UsersData[indexPath.row] as! NSDictionary
        let avatar = userData["avatar"] as! String
        let default_avatar = UIImage(named: "default_avatar")
        cell.user_profileImage.moa.url = photoUrl(avatar: avatar)
        cell.user_profileImage.moa.errorImage = default_avatar
        let userName = userData["name"] as! String
        cell.user_Namelbl.text = userName
        let userid = userData["id"] as! Int
        let user_id = String(userid) as! String
        CheckOnline(user_id: user_id,imageView: cell.online_imageView)
//      
        if (self.blockuser == false){
            cell.unblock_user.isHidden = true
        }else{
            cell.unblock_user.isHidden = false
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userData = UsersData[indexPath.row] as! NSDictionary
        let userid = userData["id"] as! Int
        let user_id = String(userid) as! String
        
        self.LoadOtherUserData(user_id: user_id)
    }
}
extension UserListVC {
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
