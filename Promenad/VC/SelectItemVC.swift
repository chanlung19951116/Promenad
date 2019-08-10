//
//  SelectItemVC.swift
//  Promenad
//
//  Created by LiuYan on 8/5/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class SelectItemVC: UIViewController {

    @IBOutlet weak var show_DataView: UITableView!
    var showLabel: UILabel!
    var showData : [String] = []
    var datatype: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        show_DataView.delegate = self
        show_DataView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Close_View(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension SelectItemVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)  as! ItemCell
        cell.textlabel.text = self.showData[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
        
        if (self.datatype == false){
            self.showLabel.text =  self.showData[indexPath.row]
        }else{
            let old_text = self.showLabel.text as! String
            if (old_text.isEmpty){
                self.showLabel.text = self.showData[indexPath.row]
            }else{
                self.showLabel.text = old_text + "," + self.showData[indexPath.row]
            }
        }
       
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
