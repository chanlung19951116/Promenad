//
//  ChatListVC.swift
//  Promenad
//
//  Created by LiuYan on 8/1/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class ChatListVC: UIViewController {

    @IBOutlet weak var chatlist_view: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        
        // Do any additional setup after loading the view.
    }
    func initUI(){
        
        
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
        LoadChatList()
    }
    

}
extension ChatListVC: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.shared.ChatData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatlistCell", for: indexPath) as! ChatListCell
        let chatData = AppData.shared.ChatData[indexPath.row] as! NSDictionary
        let username = chatData["name"] as! String
        cell.user_name.text = username
        let avatar = chatData["avatar"] as! String
        cell.user_profileImage.moa.url = photoUrl(avatar: avatar)
        let last_message = chatData["message_text"] as! String
        cell.user_lastmessage.text = last_message
        cell.user_lastmessage.isUserInteractionEnabled = false
        let milliseconds = chatData["latest_message_time"] as! String
        cell.user_chattime.text = ConvertMilliSecondstoDate(datemilliseconds: milliseconds)
        let id = chatData["id"] as! Int
        let user_id = String(id) as! String
        CheckOnline(user_id: user_id, imageView: cell.user_onlinestatus)
        let unreadmessage = chatData["unread_msg"] as! Int
        if(unreadmessage > 0){
            if (unreadmessage > 10){
                cell.user_chattype.image = UIImage(named: "chat_badge2")
            }else{
                cell.user_chattype.image = UIImage(named: "badge1")
            }
            
        }else {
            cell.user_chattype.isHidden = true
            
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatData = AppData.shared.ChatData[indexPath.row] as! NSDictionary
        let username = chatData["name"] as! String
        let avatar = chatData["avatar"] as! String
        let id = chatData["id"] as! Int
        let user_id = String(id) as! String
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "chatVC") as! ChatVC
        vc.userName = username
        vc.photourl = avatar
        vc.chatid = user_id
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
extension ChatListVC {
    func LoadChatList(){
        if (AppData.shared.ChatData.count <= 0){
            AppData.shared.showLoadingIndicator(view: self.view)
        }
        MessageService().GetChatList(){(response) in
            if let json = response {
                do {
                    AppData.shared.hideLoadingIndicator()
                    AppData.shared.ChatData = json as! NSArray
                    self.chatlist_view.dataSource = self
                    self.chatlist_view.delegate = self
                    self.chatlist_view.reloadData()
                }catch(let error){
                     AppData.shared.hideLoadingIndicator()
                }
                
            }else {
                 AppData.shared.hideLoadingIndicator()
            }
        }
    }
}
