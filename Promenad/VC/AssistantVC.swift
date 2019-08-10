//
//  AssistantVC.swift
//  Promenad
//
//  Created by LiuYan on 8/4/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class AssistantVC: UIViewController {

    @IBOutlet weak var notify_resultView: UITableView!
    var unreadNotifyData = NSArray()
    
    var NotifyData = NSMutableDictionary()
    var currenctDateString :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
    }
    func initUI(){
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        currenctDateString = dateformatter.string(from: Date())
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        let leafimage = UIImage(named: "back")!
        let notificationimage = UIImage(named: "setting")!
        
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
        LoadNotificationHistory()
    }
    @objc func Leaf_Action(){
       _ = self.navigationController?.popViewController(animated: true)
    }
    @objc func Notification(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "assistantsettingVC") as! AssitantSettingVC
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension AssistantVC: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        let keys = self.NotifyData.allKeys as! [String]
        return keys.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys = self.NotifyData.allKeys as! [String]
        let key = keys[section] as! String
        var count : Int = 0
        if (key == "today"){
            let section_data = self.NotifyData[key] as! NSArray
            count = section_data.count
        }else {
            let section_data = self.NotifyData[key] as! NSDictionary
            let section_keys = section_data.allKeys as! [String]
            if (section_keys.contains("match")) {
                let matchArray = section_data["match"] as! NSArray
                count = count + matchArray.count
            }else if(section_keys.contains("like")) {
                let visitArray = section_data["like"] as! NSArray
                count = count + visitArray.count
            }else if(section_keys.contains("visit")) {
                let likeArray = section_data["visit"] as! NSArray
                count = count + likeArray.count
            }
        }
       
        
        
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notifyCell", for: indexPath) as! NotifyCell
        cell.selectionStyle = .none
        let keys = self.NotifyData.allKeys as! [String]
        let key = keys[indexPath.section] as! String
        var cellData = NSDictionary()
        var todaycount :Int = 0
        if (key == "today"){
            let section_data = self.NotifyData["today"] as! NSArray
            todaycount = section_data.count
            if (indexPath.row < todaycount){
                cellData = section_data[indexPath.row] as! NSDictionary
            }
        }else {
            let section_data = self.NotifyData[key] as! NSDictionary
            let section_keys = section_data.allKeys as! [String]
            var match_count: Int = 0
            var like_count: Int = 0
            var visit_count: Int = 0
            
            if (section_keys.contains("match")) {
                let matchArray = section_data["match"] as! NSArray
                match_count = matchArray.count
                if (todaycount <= indexPath.row && indexPath.row < todaycount + matchArray.count) {
                    cellData = matchArray[indexPath.row] as! NSDictionary
                }
            }else if(section_keys.contains("like")) {
                let visitArray = section_data["like"] as! NSArray
                visit_count = visitArray.count
                if (todaycount +  match_count <= indexPath.row && indexPath.row < match_count + visit_count) {
                    cellData = visitArray[indexPath.row - match_count] as! NSDictionary
                }
            }else if(section_keys.contains("visit")) {
                let likeArray = section_data["visit"] as! NSArray
                like_count = likeArray.count
                if (todaycount + match_count + visit_count <= indexPath.row && indexPath.row < match_count + visit_count + like_count){
                    cellData = likeArray[indexPath.row - match_count - visit_count] as! NSDictionary
                }
            }
        }
        
        let username = cellData["name_from"] as! String
        let birthdate = cellData["birth_date_from"] as! String
        let age = getAge(birthdate: birthdate)
        if (age != "-1"){
            cell.user_nameage.text = username + ", " + age
        }else{
            cell.user_nameage.text = username
        }
        let type = cellData["type"] as! String
        if (type == "match") {
            cell.state.text = "New match"
            cell.status.image = UIImage(named: "chat_status2")
            
        }else if (type == "like"){
            cell.state.text = "New like"
            cell.status.image = UIImage(named: "ic_like")
        }else if (type == "visit") {
            cell.state.text = "You have a new visitor"
            cell.status.image = UIImage(named: "chat_status1")
        }
        let create_date = cellData["created_at"] as! String
        
        let dateString = CompareDateStrings(first: currenctDateString, second: create_date)
        print(dateString)
        cell.time_lbl.text = dateString
        let avatarr = cellData["avatar"] as! String
        cell.assistant_userImage.moa.url = photoUrl(avatar: avatarr)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width:
            tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor.white
        
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 5, width:
            tableView.bounds.size.width, height: 20))
        let color = UIColor.init(red: 132/255, green: 153/255, blue: 183/255, alpha: 1.0)
        headerLabel.textColor = color
        let keys = self.NotifyData.allKeys as! [String]
        if (keys[section] == "today"){
             headerLabel.text = "Today"
        }else{
             headerLabel.text = keys[section] as! String
        }
       
        headerLabel.textAlignment = .center
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
}
extension AssistantVC {
    func LoadNotificationHistory(){
        AppData.shared.showLoadingIndicator(view: self.view)
        NotificationService().GetNotificationHistory(){ (response) in
          if let json = response {
                do {
                    AppData.shared.hideLoadingIndicator()
                    let responseData = json as! NSDictionary
                    let responseString = AppData.shared.convertDictionaryToJsonString(response: responseData as! [String: Any]) as! String
                    if (responseString.contains("unread_notifications")){
                        self.unreadNotifyData = responseData["unread_notifications"] as! NSArray
                    }
                    let key : [String] = responseData.allKeys as! [String]
                    for index in 0..<key.count {
                        let each_key = key[index] as! String
                        if (each_key != "0" && each_key != "unread_notifications") {
                            if (each_key == "today"){
                                let each_Data = responseData["today"] as! NSArray
                                self.NotifyData.setValue(each_Data, forKey: "today")
                            }else{
                                let each_Data = responseData[each_key] as! NSDictionary
                                 self.NotifyData.setValue(each_Data, forKey: each_key)
                            }
                            
                        }
                    }
                     print(self.NotifyData)
                    self.notify_resultView.delegate = self
                    self.notify_resultView.dataSource = self
                    
                }catch(let error){
                    AppData.shared.hideLoadingIndicator()
                }
                
            } else {
            
            
            }
        }
    }
}
