//
//  SignupEmailStep2.swift
//  Promenad
//
//  Created by LiuYan on 7/30/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class SignupEmailStep2: UIViewController {

    
    @IBOutlet weak var next_btn: UILabel!
    
    @IBOutlet weak var next_view: CardView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    func initUI(){
        next_btn.font = UIFont(name: "opensans_regular", size: 5)
        next_btn.font = next_btn.font.withSize(12)
        let next_gesutre = UITapGestureRecognizer(target:self,action:#selector(self.Next_Page))
        next_btn.addGestureRecognizer(next_gesutre)
        next_view.addGestureRecognizer(next_gesutre)
    }
    @objc func Next_Page(){
        AppData.shared.verification_type = "email"
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "profilestep0") as! UserProfileStep0
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
