//
//  AssitantSettingVC.swift
//  Promenad
//
//  Created by LiuYan on 8/4/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class AssitantSettingVC: UIViewController {

    @IBOutlet weak var settting_view: UITableView!
    var imageArray :[UIImage] = [UIImage(named: "chat_status1")!,UIImage(named: "chat_status2")!,UIImage(named: "chat_status3")!,UIImage(named: "chat_status4")!]
    var titleArray : [String] = ["Visit","Match","Message","Recommendation"]
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    func initUI(){
        settting_view.dataSource = self
        settting_view.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
       
        let leafimage = UIImage(named: "back")!
        let leafBtn: UIButton = UIButton(type: UIButton.ButtonType.custom) as! UIButton
        leafBtn.setImage(leafimage, for: .normal)
        leafBtn.addTarget(self, action: #selector(Leaf_Action), for: .touchUpInside)
        leafBtn.frame = CGRect(origin : CGPoint(x:-10, y:0), size: CGSize(width: 20, height: 30))
        let leafbaritem = UIBarButtonItem(customView: leafBtn)
        self.navigationItem.setLeftBarButtonItems([leafbaritem], animated: false)
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        titleLabel.text = "Assistant's settings"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        navigationItem.titleView = titleLabel
    }
    @objc func Leaf_Action(){
        _ = self.navigationController?.popViewController(animated: true)
    }
}
extension AssitantSettingVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! HeaderCell
            cell.selectionStyle = .none
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as! ContentCell
            cell.selectionStyle = .none
            cell.chat_statusImage.image = self.imageArray[indexPath.row - 1]
            cell.title.text = self.titleArray[indexPath.row - 1]
            if (indexPath.row == 1){
                cell.view_checkbox.isChecked = true
                cell.push_checkbox.isChecked = false
            }else if (indexPath.row == 2 || indexPath.row == 3){
                cell.view_checkbox.isChecked = true
                cell.push_checkbox.isChecked = true
            }else {
                cell.view_checkbox.isChecked = false
                cell.push_checkbox.isChecked = false
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
