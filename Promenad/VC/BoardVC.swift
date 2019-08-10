//
//  BoardVC.swift
//  Promenad
//
//  Created by LiuYan on 7/29/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class BoardVC: UIViewController {

    
  
   
    @IBOutlet weak var page_indicator: UIImageView!
    @IBOutlet weak var containerView: UIView!
    var pageVC : PageVC!
    var running: Bool = true
    @IBOutlet weak var skip_btn: UILabel!
    
    @IBOutlet weak var next_view: CardView!
    @IBOutlet weak var next_btn: UILabel!
    var page_ImageArray : [UIImage] = [UIImage(named: "first_page")!,UIImage(named: "second_page")!,UIImage(named: "third_page")!]
    var flag: Int = 0
    override func viewDidLoad() {
        initUI()
        let thread = Thread.init(target: self, selector: #selector(updatePage), object: nil)
        thread.start()
        
    }
    @objc func updatePage(){
        while (self.running == true) {
          //  print("test")
            DispatchQueue.main.async {
                self.page_indicator.image = self.page_ImageArray[AppData.shared.index]
                if (AppData.shared.index < 2) {
                    self.next_btn.text = "NEXT"
                    self.flag = 0
                }else if (AppData.shared.index == 2){
                    self.next_btn.text = "GO"
                    self.flag = 1
                }
            }
        }
        
    }
    
    func initUI(){
        skip_btn.font = UIFont(name: "opensans_regular", size: 1)
        skip_btn.font = skip_btn.font.withSize(10)
        next_btn.font = UIFont(name: "opensans_regular", size: 5)
        next_btn.font = next_btn.font.withSize(12)
       
        skip_btn.isUserInteractionEnabled = true
        next_btn.isUserInteractionEnabled = true
        let skip_gesutre = UITapGestureRecognizer(target:self,action:#selector(self.Skip_Page))
        let next_gesutre = UITapGestureRecognizer(target:self,action:#selector(self.Next_Page))
        // add it to the label
        skip_btn.addGestureRecognizer(skip_gesutre)
        next_btn.addGestureRecognizer(next_gesutre)
        next_view.addGestureRecognizer(next_gesutre)
        self.page_indicator.image = self.page_ImageArray[AppData.shared.index]
    }
    @objc func Skip_Page(){
        if (AppData.shared.index < 2) {
            pageVC.setViewControllerFromIndex(index: AppData.shared.index + 1)
            AppData.shared.index = AppData.shared.index + 1
            self.page_indicator.image = self.page_ImageArray[AppData.shared.index]
            self.next_btn.text = "NEXT"
            self.flag = 0
        }else if (AppData.shared.index == 2) {
            self.next_btn.text = "GO"
            self.flag = 1
        }
        if (self.flag == 1){
            self.running = false
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "signinmainVC") as! SigninMainVC
            // self.present(verificationController, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    @objc func Next_Page(){
        if (AppData.shared.index < 2) {
            pageVC.setViewControllerFromIndex(index: AppData.shared.index + 1)
            AppData.shared.index = AppData.shared.index + 1
            self.page_indicator.image = self.page_ImageArray[AppData.shared.index]
            self.next_btn.text = "NEXT"
            self.flag = 0
        }else if (AppData.shared.index == 2) {
            self.next_btn.text = "GO"
            self.flag = 1
        }
        if (self.flag == 1){
            self.running = false
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "signinmainVC") as! SigninMainVC
            // self.present(verificationController, animated: true, completion: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if (segue.identifier == "pageVC"){
            if (segue.destination.isKind(of: PageVC.self)) {
                pageVC = segue.destination as! PageVC
            }
        }
    }
    
    
}
