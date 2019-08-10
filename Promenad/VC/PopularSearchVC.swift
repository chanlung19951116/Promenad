//
//  PopularSearchVC.swift
//  Promenad
//
//  Created by LiuYan on 8/3/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class PopularSearchVC: UIViewController {

    
    
    @IBOutlet weak var Open_filterView: CardView!
    
    @IBOutlet weak var search_resultView: UICollectionView!
    var UsersData = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    func initUI(){
        search_resultView.dataSource = self
        search_resultView.delegate = self
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
        let filter_gesture = UITapGestureRecognizer(target:self,action:#selector(self.openFilter))
        Open_filterView.addGestureRecognizer(filter_gesture)
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
    @objc func openFilter(){
        let filterDialog = FilterDialog(title: "",vc: self)
        filterDialog.show(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
}
extension PopularSearchVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.UsersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! SearchCell
        let cellData = self.UsersData[indexPath.row] as! NSDictionary
        let imageDataString = cellData["min_avatar"] as! String
        let imageString = imageDataString.components(separatedBy: ",")
        let encodedString = imageString[1]
        let imageData = Data(base64Encoded: encodedString, options: .ignoreUnknownCharacters)!
        let decodeimage: UIImage = UIImage(data: imageData)!
        let name = cellData["name"] as! String
        let distance = cellData["distance"] as! Double
        let int_dist = Int(distance) as! Int
        let distance_str = String(int_dist) as! String
        
        cell.avatar_view.image = decodeimage
        cell.avatar_name.text = name
        cell.avatar_distance.text = distance_str + "m"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellData = self.UsersData[indexPath.row] as! NSDictionary
        let otheruserid = cellData["id"] as! Int
        let userid = AppData.shared.UserData["id"] as! Int
        if (otheruserid != userid) {
            let user_id = String(otheruserid) as! String
            self.LoadOtherUserData(user_id: user_id)
        }
    }
    
}

extension PopularSearchVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        return CGSize(width: (bounds.width - 24) / 3, height: (bounds.width - 24) / 3)
    }
}
extension PopularSearchVC {
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
