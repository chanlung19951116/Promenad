//
//  UserProfileStep1.swift
//  Promenad
//
//  Created by LiuYan on 7/30/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit

class UserProfileStep1: UIViewController {

    
    @IBOutlet weak var back_btn: UIImageView!
    //Select Gender part
    @IBOutlet weak var gender_man: CardView!
    @IBOutlet weak var gender_woman: CardView!
    @IBOutlet weak var genderwoman_image: UIImageView!
    @IBOutlet weak var genderman_image: UIImageView!
    @IBOutlet weak var gender_womanheight: NSLayoutConstraint!
    @IBOutlet weak var gedner_womanwidht: NSLayoutConstraint!
    @IBOutlet weak var gender_manheight: NSLayoutConstraint!
    @IBOutlet weak var gender_manwidth: NSLayoutConstraint!
    //Select Lookfor part
    @IBOutlet weak var lookfor_woman: CardView!
    @IBOutlet weak var lookfor_man: CardView!
    @IBOutlet weak var lookfor_bi: CardView!
    
    @IBOutlet weak var lookforwoman_width: NSLayoutConstraint!
    @IBOutlet weak var lookforwoman_height: NSLayoutConstraint!
    @IBOutlet weak var lookforman_height: NSLayoutConstraint!
    @IBOutlet weak var lookforman_width: NSLayoutConstraint!
    @IBOutlet weak var lookforbi_height: NSLayoutConstraint!
    @IBOutlet weak var lookforbi_width: NSLayoutConstraint!
    @IBOutlet weak var lookforman_image: UIImageView!
    @IBOutlet weak var lookforwoman_image: UIImageView!
    @IBOutlet weak var lookforbi_image: UIImageView!
    
    
    @IBOutlet weak var center_flowlayout: SJCenterFlowLayout!
    
    @IBOutlet weak var relation_view: UICollectionView!
    @IBOutlet weak var next_view: CardView!
    
    @IBOutlet weak var purpost_titlelbl: UILabel!
    
    
    
    var flag: Int = 0
    var strDatingPurpose: String = "None Selected"
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initUI()
        // Do any additional setup after loading the view.
    }
    func initUI(){
        let back_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Back_action))
        back_btn.addGestureRecognizer(back_gesture)
        back_btn.isUserInteractionEnabled = true
        relation_view.delegate = self
        relation_view.dataSource = self
//        let layout = LNZSnapToCenterCollectionViewLayout()
//        relation_view.collectionViewLayout = layout
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
//            let firstindex = IndexPath(item: 52, section: 0)
//            let startindex = IndexPath(item: 0, section: 0)
//            print(firstindex.row)
//            self.relation_view.scrollToItem(at: firstindex, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
//
//        }
        let next_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Next_Page))
        next_view.addGestureRecognizer(next_gesture)
        //Select Gender Gesture
        let genderman_gesture = UITapGestureRecognizer(target:self,action:#selector(self.genderMan))
        let genderwoman_gesture = UITapGestureRecognizer(target:self,action:#selector(self.genderWoMan))
        self.gender_man.addGestureRecognizer(genderman_gesture)
        self.gender_woman.addGestureRecognizer(genderwoman_gesture)
        //Select lookfor Gesture
        let lookforman_gesture = UITapGestureRecognizer(target:self,action:#selector(self.lookforman))
        let lookforwoman_gesture = UITapGestureRecognizer(target:self,action:#selector(self.lookforwoman))
        let lookforbi_gesture = UITapGestureRecognizer(target:self,action:#selector(self.lookforbi))
        self.lookfor_man.addGestureRecognizer(lookforman_gesture)
        self.lookfor_woman.addGestureRecognizer(lookforwoman_gesture)
        self.lookfor_bi.addGestureRecognizer(lookforbi_gesture)
        self.center_flowlayout.animationMode = SJCenterFlowLayoutAnimation.scale(sideItemScale: 0.8, sideItemAlpha: 1.0, sideItemShift: 5.0)
        self.center_flowlayout.spacingMode = SJCenterFlowLayoutSpacingMode.fixed(spacing: 10.0)
        self.center_flowlayout.minimumLineSpacing = 0
        self.center_flowlayout.itemSize = CGSize(
            width: 72,
            height:  72
        )
       
       // print(self.relation_view.visibleCells.count)
        
        self.center_flowlayout.scrollToPage(atIndex: 2)
       
        
        
    }
   //select Gender Part
    @objc func genderMan(){
        let shadow_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        self.gender_man.shadowColor = shadow_color
        self.gender_woman.shadowColor = UIColor.darkGray
        
        self.gender_manwidth.constant = 60
        self.gender_manheight.constant = 60
        self.gender_womanheight.constant = 50
        self.gedner_womanwidht.constant = 50
        self.genderman_image.image = UIImage(named: "man_sel")
        self.genderwoman_image.image = UIImage(named: "bi")
        AppData.shared.userGender = "Male"
        
    }
    @objc func genderWoMan(){
        let shadow_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        self.gender_man.shadowColor = UIColor.darkGray
        self.gender_woman.shadowColor = shadow_color
        self.gender_manwidth.constant = 50
        self.gender_manheight.constant = 50
        self.gender_womanheight.constant = 60
        self.gedner_womanwidht.constant = 60
        self.genderman_image.image = UIImage(named: "man")
        self.genderwoman_image.image = UIImage(named: "bi_sel")
        AppData.shared.userGender = "Female"
    }
    @objc func lookforman(){
        let shadow_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        self.lookfor_man.shadowColor = shadow_color
        self.lookforman_height.constant = 60
        self.lookforman_width.constant = 60
        self.lookforman_image.image = UIImage(named: "man_sel")
        self.lookfor_woman.shadowColor = UIColor.darkGray
        self.lookforwoman_width.constant = 50
        self.lookforwoman_height.constant = 50
        self.lookforwoman_image.image = UIImage(named: "bi")
        self.lookfor_bi.shadowColor = UIColor.darkGray
        self.lookforbi_width.constant = 50
        self.lookforbi_height.constant = 50
        self.lookforbi_image.image = UIImage(named: "Group3")
        AppData.shared.userLooking_for = "Male"
        
    }
    @objc func lookforwoman(){
        let shadow_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        self.lookfor_man.shadowColor = UIColor.darkGray
        self.lookforman_height.constant = 50
        self.lookforman_width.constant = 50
        self.lookforman_image.image = UIImage(named: "man")
        self.lookfor_woman.shadowColor = shadow_color
        self.lookforwoman_width.constant = 60
        self.lookforwoman_height.constant = 60
        self.lookforwoman_image.image = UIImage(named: "bi_sel")
        self.lookfor_bi.shadowColor = UIColor.darkGray
        self.lookforbi_width.constant = 50
        self.lookforbi_height.constant = 50
        self.lookforbi_image.image = UIImage(named: "Group3")
        AppData.shared.userLooking_for = "Female"
    }
    @objc func lookforbi(){
        let shadow_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        self.lookfor_man.shadowColor = UIColor.darkGray
        self.lookforman_height.constant = 50
        self.lookforman_width.constant = 50
        self.lookforman_image.image = UIImage(named: "man")
        self.lookfor_woman.shadowColor = UIColor.darkGray
        self.lookforwoman_width.constant = 50
        self.lookforwoman_height.constant = 50
        self.lookforwoman_image.image = UIImage(named: "bi")
        self.lookfor_bi.shadowColor = shadow_color
        self.lookforbi_width.constant = 60
        self.lookforbi_height.constant = 60
        self.lookforbi_image.image = UIImage(named: "Group3_sel")
        AppData.shared.userLooking_for = "Both"
    }
    @objc func Next_Page(){
        if (AppData.shared.userGender.isEmpty){
            AppData.shared.displayToastMessage("Please select gender.")
            return
        }
        if (AppData.shared.userLooking_for.isEmpty){
            AppData.shared.displayToastMessage("Please select looking for.")
            return
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "userprofilestep2VC") as! UserProfileStep2
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func Back_action(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(self.center_flowlayout.currentCenteredPage)
        if (self.center_flowlayout.currentCenteredPage != nil) {
            let index = self.center_flowlayout.currentCenteredPage as! Int
            self.purpost_titlelbl.text = AppData.shared.DatingPurposeDisplayArray[index]
            AppData.shared.purpose_of_dating = AppData.shared.DatingPurposeArray[index]
            for index_item in 0..<5 {
                let cellindexpath = IndexPath(item: index_item, section: 0)
                let cell = self.relation_view.dequeueReusableCell(withReuseIdentifier: "relationCell", for: cellindexpath) as! RelationCell
                if (index_item != index) {
                    switch index_item {
                        case 0:
                            cell.imageView.image = UIImage(named: "smile")
                            
                            break
                        case 1:
                            cell.imageView.image = UIImage(named: "plane")
                            
                            break
                        case 2:
                            cell.imageView.image = UIImage(named: "ic_love")
                        
                            break
                        case 3:
                            cell.imageView.image = UIImage(named: "chat")
                            
                            break
                        case 4:
                            cell.imageView.image = UIImage(named: "five")
                           
                            break
                        default:
                            cell.imageView.image = UIImage(named: "five")
                            
                            break
                    }
                }else{
                    switch index_item {
                        case 0:
                            
                            cell.imageView.image = UIImage(named: "smile_sel")
                            break
                        case 1:
                            
                            cell.imageView.image = UIImage(named: "plane_sel")
                            break
                        case 2:
                         
                            cell.imageView.image = UIImage(named: "love")
                            break
                        case 3:
                          
                            cell.imageView.image = UIImage(named: "chat_sel")
                            break
                        case 4:
                           
                            cell.imageView.image = UIImage(named: "five_sel")
                            break
                        default:
                            
                            cell.imageView.image = UIImage(named: "five_sel")
                            break
                            
                    }
                }
            }
            
        }
    }
    
}
extension UserProfileStep1: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "relationCell", for: indexPath) as! RelationCell
        let index_item = indexPath.row % 5
        switch index_item {
            case 0:
                cell.imageView.image = UIImage(named: "smile")
                break
            case 1:
                cell.imageView.image = UIImage(named: "plane")
                break
            case 2:
                cell.imageView.image = UIImage(named: "love")
                break
            case 3:
                cell.imageView.image = UIImage(named: "chat")
                break
            case 4:
                cell.imageView.image = UIImage(named: "five")
                break
            default:
                cell.imageView.image = UIImage(named: "five")
                break
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
  
}


