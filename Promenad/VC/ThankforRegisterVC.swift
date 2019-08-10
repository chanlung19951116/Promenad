//
//  ThankforRegisterVC.swift
//  Promenad
//
//  Created by LiuYan on 8/1/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class ThankforRegisterVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
         
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "containVC") as! ContainVC
            // self.present(verificationController, animated: true, completion: nil)
            self.present(vc, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
}
