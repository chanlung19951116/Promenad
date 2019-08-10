//
//  SignupEmailStep1.swift
//  Promenad
//
//  Created by LiuYan on 7/30/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class SignupEmailStep1: UIViewController {

    var thread : Thread!
    var running: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        checkEmailVerification()
    }
   
    
    func checkEmailVerification(){
        EmailService().CheckEmailVerificationStatus(email: AppData.shared.userEmail){(response) in
            DispatchQueue.main.async {
                
                if let json = response {
                    do {
                        
                        let resultData = json as! NSDictionary
                        let status = resultData["status"] as! Int
                        if (status == 1) {
                            self.running = false
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyBoard.instantiateViewController(withIdentifier: "signupemailstep2VC") as! SignupEmailStep2
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else {
                            self.checkEmailVerification()
                        }
                        
                    }
                    catch(let error){
                      
                    }
                }
                else {
                    self.checkEmailVerification()
                    print("Response was nil")
                }
            }
        }
        
        
        
    }
    
}
