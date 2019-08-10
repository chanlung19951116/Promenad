//
//  UserProfileStep3.swift
//  Promenad
//
//  Created by LiuYan on 7/31/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class UserProfileStep3: UIViewController{

    @IBOutlet weak var next_view: CardView!
    

    @IBOutlet weak var user_height: NSLayoutConstraint!
    
    @IBOutlet weak var user_width: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    func initUI(){
       
        
        let next_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Next_Page))
        next_view.addGestureRecognizer(next_gesture)
    }
    @objc func Next_Page(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "userprofilestep4VC") as! UserProfileStep4
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

