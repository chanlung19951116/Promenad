//
//  ChatVC.swift
//  Promenad
//
//  Created by LiuYan on 8/2/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var chatListView: UITableView!
    var userName: String = ""
    var photourl: String = ""
    var chatid: String = ""
    var chatData = NSArray()
    var ResortChatData = NSMutableDictionary()
    var keysarray: [String] = []
    
    @IBOutlet weak var bottom_height: NSLayoutConstraint!
    
    @IBOutlet weak var message_field: UITextField!
    
    @IBOutlet weak var send_btn: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        NotificationCenter.default.addObserver(self, selector: #selector(self.showKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    @objc func showKeyboard(notification: Notification) {
        if let frame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let height = frame.cgRectValue.height
            
            if DeviceType.iPhoneX {
                bottom_height.constant =  height
            }else {
                bottom_height.constant =  height
            }
            DispatchQueue.main.async {
                let count = self.keysarray.count
                let key_last  = self.keysarray[0] as! String
                let datelast_chatData = self.ResortChatData[key_last] as! NSArray
                let row = datelast_chatData.count - 1
                self.chatListView.scrollToRow(at: IndexPath.init(row: row, section: self.keysarray.count - 1), at: .bottom, animated: false)
            }
        }
    }
    @objc func hideKeyboard(notification: Notification) {
        if DeviceType.iPhoneX {
            bottom_height.constant = 0
        }else {
            bottom_height.constant = 0
        }
    }
    func initUI(){
        self.chatListView.delegate = self
        self.chatListView.dataSource = self
        self.tabBarController?.tabBar.isHidden = true
        let leafimage = UIImage(named: "back")!
        let userimage = UIImage(named: "sample_profile2")!
         self.tabBarController?.tabBar.isHidden = true
        let leafBtn: UIButton = UIButton(type: UIButton.ButtonType.custom) as! UIButton
        leafBtn.setImage(leafimage, for: .normal)
        leafBtn.addTarget(self, action: #selector(Leaf_Action), for: .touchUpInside)
        leafBtn.frame = CGRect(origin : CGPoint(x:-10, y:0), size: CGSize(width: 20, height: 30))
        let leafbaritem = UIBarButtonItem(customView: leafBtn)
        let uiview = UIView(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
        let userAvatar: UIImageView = UIImageView(frame:CGRect(x: 0, y: 0, width: 30, height: 30) )
        userAvatar.moa.url = photoUrl(avatar: self.photourl)
        userAvatar.layer.cornerRadius = 15
        userAvatar.layer.masksToBounds = true
        userAvatar.clipsToBounds = true
        userAvatar.contentMode = .scaleAspectFit
        uiview.addSubview(userAvatar)
        let userAvatarView = UIBarButtonItem(customView: uiview)
        let userNameLbl : UILabel = UILabel(frame: CGRect(x: 50, y: 0, width: 200, height: 30))
        userNameLbl.textColor = UIColor.black
        userNameLbl.textAlignment = .left
        userNameLbl.text = userName
        let userNameView = UIBarButtonItem(customView: userNameLbl)
        self.navigationItem.setLeftBarButtonItems([leafbaritem,userAvatarView,userNameView], animated: false)
        let send_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Send_Messsage))
        self.send_btn.addGestureRecognizer(send_gesture)
        self.send_btn.isUserInteractionEnabled = true
    }
    @objc func Send_Messsage(){
        self.view.endEditing(true)
        let message = self.message_field.text as! String
        if (message.count > 0){
            MessageService().SendMessage(user_id: self.chatid, msg: message){(response) in
               if let json = response {
                    do {
                        let data = json as! NSDictionary
                        print(data)
                        let from_id = data["from_id"] as! Int
                        let user_id = AppData.shared.UserData["id"] as! Int
                        if (from_id == user_id){
                            self.message_field.text = ""
                            self.LoadMessages(chatid: self.chatid)
                        }
                        
                    }catch(let error){
                        
                    }
                }
            }
        }
    }
    @objc func Leaf_Action(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.LoadMessages(chatid: self.chatid)
    }
    func LoadMessages(chatid: String){
        self.keysarray = []
        self.ResortChatData = NSMutableDictionary()
        self.chatData = NSArray()
        MessageService().LoadMessages(user_id: chatid) {(response) in
            if let json = response {
                do {
                    self.chatData = response as! NSArray
                    print(self.chatData)
                    var key: String = ""
                    var date_chatData = NSMutableArray()
                    for index in 0..<self.chatData.count {
                        let each_chatData = self.chatData[index] as! NSDictionary
                        if let date_splitter = each_chatData["date_splitter"] as? String {
                            if(key != date_splitter) {
                                self.keysarray.append(date_splitter)
                                if (index == 0){
                                    key = date_splitter
                                     date_chatData.add(each_chatData)
                                }else {
                                    self.ResortChatData.setValue(date_chatData, forKey: key)
                                    key = date_splitter
                                    date_chatData = NSMutableArray()
                                    date_chatData.add(each_chatData)
                                    
                                }
                                
                            }
                        }else {
                            date_chatData.add(each_chatData)
                            if (index == self.chatData.count - 1){
                                self.ResortChatData.setValue(date_chatData, forKey: key)
                            }
                        }
                    }
                    print(self.ResortChatData)
                    print(self.keysarray)
                    self.chatListView.reloadData()
                    DispatchQueue.main.async {
                        let count = self.keysarray.count
                        let key_last  = self.keysarray[0] as! String
                        let datelast_chatData = self.ResortChatData[key_last] as! NSArray
                        let row = datelast_chatData.count - 1
                        self.chatListView.scrollToRow(at: IndexPath.init(row: row, section: self.keysarray.count - 1), at: .bottom, animated: false)
                    }
                    
                    
                }catch(let error){
                    
                }
            }else{
                
            }
        }
        
    }
}
extension ChatVC : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return self.keysarray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.keysarray.count - 1
        let key  = self.keysarray[count - section] as! String
        let date_chatData = self.ResortChatData[key] as! NSArray
        return date_chatData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let keys = self.ResortChatData.allKeys as! [String]
        let count = self.keysarray.count - 1
        let key  = self.keysarray[count - indexPath.section] as! String
        let date_chatData = self.ResortChatData[key] as! NSArray
        let date_count = date_chatData.count - 1
        let each_data = date_chatData[date_count - indexPath.row] as! NSDictionary
        let from_id = each_data["mess_from"] as! String
        let from_id_str = String(from_id) as! String
        let mess = each_data["mess"] as! String
        let time = each_data["time"] as! String
        if (from_id_str == self.chatid){
            let cell = tableView.dequeueReusableCell(withIdentifier: "senderCell", for: indexPath) as! SenderCell
            let bgcolor = UIColor.init(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
            cell.MessageBackground.layer.borderColor = UIColor.lightGray.cgColor
            cell.MessageBackground.layer.cornerRadius = 2
            cell.MessageBackground.layer.backgroundColor = bgcolor.cgColor
            cell.MessageBackground.layer.masksToBounds = true
            cell.MessageBackground.layer.borderWidth = 1
            cell.messageView.text = mess
            cell.messageView.textColor = UIColor.black
            cell.time_label.text = time
            //cell.time_label.textColor = UIColor.black
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "receiverCell", for: indexPath) as! ReceiverCell
            let bgcolor = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
            cell.MessageBackground.layer.backgroundColor = bgcolor.cgColor
            cell.MessageBackground.layer.cornerRadius = 2
            cell.MessageBackground.layer.masksToBounds = true
            cell.Message.text = mess
            cell.Message.textColor = UIColor.white
            cell.time_label.text = time
            cell.selectionStyle = .none
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width:
            tableView.bounds.size.width, height: 30))
        let bgcolor = UIColor.init(red: 239/255, green: 239/255, blue: 244/255, alpha: 1.0)
        headerView.backgroundColor = bgcolor
        
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 5, width:
            tableView.bounds.size.width, height: 20))
        let color = UIColor.init(red: 132/255, green: 153/255, blue: 183/255, alpha: 1.0)
        headerLabel.textColor = color
        
        let count = self.keysarray.count - 1
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd MMM yyyy"
        let now_date = dateformatter.string(from: Date())
        if (now_date == self.keysarray[count - section]){
            headerLabel.text = "Today"
        }else{
            let now_strings = now_date.components(separatedBy: " ")
            let key = self.keysarray[count - section] as! String
            let key_datas = key.components(separatedBy: " ")
            if (now_strings[2] == key_datas[2]) {
                if (now_strings[1] == key_datas[1]){
                    let now_day = Int(now_strings[0]) as! Int
                    let key_day = Int(key_datas[0]) as! Int
                    if (key_day == (now_day - 1)){
                        headerLabel.text = "Yesterday"
                    }else {
                          headerLabel.text = key
                    }
                }else{
                    headerLabel.text = key
                }
            }else{
                 headerLabel.text = key
            }
        }
        headerLabel.textAlignment = .center
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
}
