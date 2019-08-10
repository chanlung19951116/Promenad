//
//  EditProfileVC.swift
//  Promenad
//
//  Created by LiuYan on 8/4/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit
import TTRangeSlider
class EditProfileVC: UIViewController {

    @IBOutlet weak var user_marriage_married: UILabel!
    @IBOutlet weak var user_marriage_notmarried: UILabel!
    @IBOutlet weak var user_marriage_divorced: UILabel!
    
    @IBOutlet weak var user_orientation_hetero: UILabel!
    @IBOutlet weak var user_orientation_homo: UILabel!
    @IBOutlet weak var user_orientation_bi: UILabel!
   
    @IBOutlet weak var user_language: UILabel!
    @IBOutlet weak var user_profession: UILabel!
    @IBOutlet weak var user_placeofwork: UITextField!
    @IBOutlet weak var user_nationality: UILabel!
    @IBOutlet weak var user_religion: UILabel!
    @IBOutlet weak var user_aboutme: UITextView!
    @IBOutlet weak var user_photoView:UICollectionView!
    @IBOutlet weak var user_interest:UICollectionView!
    
    @IBOutlet weak var user_growth: TTRangeSlider!
    
    @IBOutlet weak var user_weight: TTRangeSlider!
    
    @IBOutlet weak var user_childrencount: TTRangeSlider!
    
    @IBOutlet weak var photoView_height: NSLayoutConstraint!

    
    @IBOutlet weak var view_height: NSLayoutConstraint!
    @IBOutlet weak var interest_heightvalue: NSLayoutConstraint!
    //Show example interestArray;
    
    var interestString: [String] = ["Sport","Travel","Shopping","Adventure", "Drawing","Reading"]
    var photoData  = NSArray()
    var photoDataString = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }
    func initUI(){
        
        photoView_height.constant = (self.user_photoView.bounds.width / 3) * 2
       
        
        if (photoView_height.constant > 170){
            view_height.constant = view_height.constant + photoView_height.constant - 170
        }
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        let leafimage = UIImage(named: "back")!
        let notificationimage = UIImage(named: "setting")!
        
        let leafBtn: UIButton = UIButton(type: UIButton.ButtonType.custom) as! UIButton
        leafBtn.setImage(leafimage, for: .normal)
        leafBtn.addTarget(self, action: #selector(Leaf_Action), for: .touchUpInside)
        leafBtn.frame = CGRect(origin : CGPoint(x:-10, y:0), size: CGSize(width: 20, height: 30))
        let leafbaritem = UIBarButtonItem(customView: leafBtn)
        
        let noti_btn: UIButton = UIButton(type: UIButton.ButtonType.custom) as! UIButton
        noti_btn.setImage(notificationimage, for: .normal)
        noti_btn.addTarget(self, action: #selector(Notification), for: .touchUpInside)
        noti_btn.frame = CGRect(origin : CGPoint(x:-10, y:0), size: CGSize(width: 20, height: 30))
        let notiBtn = UIBarButtonItem(customView: noti_btn)
        self.navigationItem.setRightBarButtonItems([notiBtn], animated: false)
        self.navigationItem.setLeftBarButtonItems([leafbaritem], animated: false)
        
        let logo_image = UIImage(named: "logo_small")
        let imageView = UIImageView(image:logo_image)
        navigationItem.titleView = imageView
        
        //Marriage Gesture
        let married_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Marriage_Married))
        let notmarried_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Marriage_Married))
        let divorced_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Marriage_Married))
        self.user_marriage_married.addGestureRecognizer(married_gesture)
        self.user_marriage_married.isUserInteractionEnabled = true
        self.user_marriage_notmarried.addGestureRecognizer(notmarried_gesture)
        self.user_marriage_notmarried.isUserInteractionEnabled = true
        self.user_marriage_divorced.addGestureRecognizer(divorced_gesture)
        self.user_marriage_divorced.isUserInteractionEnabled = true
        
        //Orientation Gesture
        let orientation_Hetero = UITapGestureRecognizer(target:self,action:#selector(self.Orientation_Hetero))
        let orientation_Homo = UITapGestureRecognizer(target:self,action:#selector(self.Orientation_Homo))
        let prientation_Bi = UITapGestureRecognizer(target:self,action:#selector(self.Orientation_Bi))
        self.user_orientation_hetero.addGestureRecognizer(orientation_Hetero)
        self.user_orientation_hetero.isUserInteractionEnabled = true
        self.user_orientation_homo.addGestureRecognizer(orientation_Homo)
        self.user_orientation_homo.isUserInteractionEnabled = true
        self.user_orientation_bi.addGestureRecognizer(prientation_Bi)
        self.user_orientation_bi.isUserInteractionEnabled = true
        
        //Language Gesture
        let lang_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Language))
        self.user_language.addGestureRecognizer(lang_gesture)
        self.user_language.isUserInteractionEnabled = true
       
        //Profession Gesutre
        let profession_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Profession))
        self.user_profession.addGestureRecognizer(profession_gesture)
        self.user_profession.isUserInteractionEnabled = true
       
        //Religion Gesture
        let religion_gesture = UITapGestureRecognizer(target:self,action:#selector(self.Religion))
        self.user_religion.addGestureRecognizer(religion_gesture)
        self.user_religion.isUserInteractionEnabled = true
        
        self.loadProfile()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    @objc func Marriage_Married(){
        let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        self.user_marriage_married.textColor = bgselect_color
        self.user_marriage_notmarried.textColor = UIColor.lightGray
        self.user_marriage_divorced.textColor = UIColor.lightGray
    }
    @objc func Marriage_NotMarried(){
        let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        self.user_marriage_married.textColor = UIColor.lightGray
        self.user_marriage_notmarried.textColor = bgselect_color
        self.user_marriage_divorced.textColor = UIColor.lightGray
    }
    @objc func Marriage_Divorced(){
        let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        self.user_marriage_married.textColor = UIColor.lightGray
        self.user_marriage_notmarried.textColor = UIColor.lightGray
        self.user_marriage_divorced.textColor = bgselect_color
    }
    @objc func Orientation_Hetero(){
        let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        self.user_orientation_hetero.textColor = bgselect_color
        self.user_orientation_homo.textColor = UIColor.lightGray
        self.user_orientation_bi.textColor = UIColor.lightGray
    }
    @objc func Orientation_Homo(){
        let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        self.user_orientation_hetero.textColor = UIColor.lightGray
        self.user_orientation_homo.textColor = bgselect_color
        self.user_orientation_bi.textColor = UIColor.lightGray
    }
    @objc func Orientation_Bi(){
        let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
        self.user_orientation_hetero.textColor = UIColor.lightGray
        self.user_orientation_homo.textColor = UIColor.lightGray
        self.user_orientation_bi.textColor = bgselect_color
    }
    @objc func Language(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "selectitemVC") as! SelectItemVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.showData = AppConstant.langauges
        vc.showLabel = self.user_language
        vc.datatype = true
        present(vc, animated: true, completion: nil)
    }
    @objc func Religion(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "selectitemVC") as! SelectItemVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.showData = AppConstant.religions
        vc.showLabel = self.user_religion
        vc.datatype = false
        present(vc, animated: true, completion: nil)
    }
    @objc func Profession(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "selectitemVC") as! SelectItemVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.showData = AppConstant.professions
        vc.showLabel = self.user_profession
        vc.datatype = false
        present(vc, animated: true, completion: nil)
    }
    @objc func Leaf_Action(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    @objc func Notification(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "assistantVC") as! AssistantVC
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func loadProfile(){
        let interest = AppData.shared.UserData["interests"] as! String
        if (!interest.isEmpty){
            self.interestString = interest.components(separatedBy: ",")
        }else{
            self.interestString = interest.components(separatedBy: ",")
        }
        if (interestString.count % 3 == 0){
            let count = interestString.count / 3 as! Int
            let fl_count = CGFloat(count) as! CGFloat
            interest_heightvalue.constant = fl_count * 38
            
        }else {
            let count = interestString.count / 3 as! Int
            let fl_count = CGFloat(count + 1) as! CGFloat
            interest_heightvalue.constant = fl_count * 38
        }
        self.photoData = AppData.shared.UserData["photos"] as! NSArray
        for index in 0..<6 {
            if (index < self.photoData.count){
                let each_photo = self.photoData[index] as! NSDictionary
                let photourl = each_photo["photo_min"] as! String
                self.photoDataString.append(photourl)
            }else{
                 self.photoDataString.append("")
            }
            
        }
        if (interest_heightvalue.constant > 128) {
            view_height.constant = view_height.constant + interest_heightvalue.constant - 128
        }
        user_photoView.delegate = self
        user_photoView.dataSource = self
        user_photoView.dragInteractionEnabled = true
        user_photoView.dragDelegate = self
        user_photoView.dropDelegate = self
//        user_photoView.dropDelegate = self
        user_photoView.dragInteractionEnabled = true
        user_interest.delegate = self
        user_interest.dataSource = self
        
        let orientation = AppData.shared.UserData["orientation"] as! String
        if (!orientation.isEmpty) {
            if (orientation == "Bisexual"){
                let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
                self.user_orientation_hetero.textColor = UIColor.lightGray
                self.user_orientation_homo.textColor = UIColor.lightGray
                self.user_orientation_bi.textColor = bgselect_color
            }else if (orientation == "Heterosexual"){
                let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
                self.user_orientation_hetero.textColor = bgselect_color
                self.user_orientation_homo.textColor = UIColor.lightGray
                self.user_orientation_bi.textColor = UIColor.lightGray
            }else if(orientation == "Homosexual"){
                let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
                self.user_orientation_hetero.textColor = UIColor.lightGray
                self.user_orientation_homo.textColor = bgselect_color
                self.user_orientation_bi.textColor = UIColor.lightGray
            }
        }
        let languages = AppData.shared.UserData["languages"] as! String
        if (!languages.isEmpty && languages != "empty"){
            self.user_language.text = languages
        }else {
            self.user_language.text = ""
        }
        let profession = AppData.shared.UserData["profession"] as! String
        if (!profession.isEmpty){
            self.user_profession.text = profession
        }else {
            self.user_profession.text = ""
        }
        let place_of_work = AppData.shared.UserData["place_of_work"] as! String
        if (!place_of_work.isEmpty && place_of_work != "empty"){
            self.user_placeofwork.text = place_of_work
        }else{
            self.user_placeofwork.text = ""
        }
        let religion = AppData.shared.UserData["religion"] as! String
        if (!religion.isEmpty){
            self.user_religion.text = religion
        }else {
            self.user_religion.text = ""
        }
        let about = AppData.shared.UserData["about"] as! String
        if (!about.isEmpty){
            self.user_aboutme.text = about
        }else {
             self.user_aboutme.text = ""
        }
        let children = AppData.shared.UserData["children"] as! String
        if (!children.isEmpty && children != "undefined" && children != "None selected") {
            let oldvalue = Float(children) as! Float
           // let value = CGFloat(oldvalue) as! CGFloat
            self.user_childrencount.selectedMaximum = oldvalue
        }else {
             self.user_childrencount.selectedMaximum = 0
        }
        if let weight = AppData.shared.UserData["weight"] as? NSNull {
            self.user_weight.selectedMaximum = 0
        }else{
            let weight = AppData.shared.UserData["weight"] as! Int
            let weightvalue = Float(weight) as! Float
            self.user_weight.selectedMaximum = weightvalue
        }
        if let growth = AppData.shared.UserData["growth"] as? NSNull {
            self.user_growth.selectedMaximum = 0
        }else{
            let growth = AppData.shared.UserData["growth"] as! Int
            let weightvalue = Float(growth) as! Float
            self.user_growth.selectedMaximum = weightvalue
        }
        
        
        let numberformatter = FeedDurationFormatter()
        self.user_weight.numberFormatterOverride = numberformatter
        
        
    }
    @IBAction func Save_Profile(_ sender: Any) {
        
    }
    


}
extension EditProfileVC: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == self.user_photoView) {
            //photo count
            return 6
        } else {
            return interestString.count + 1
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == self.user_photoView) {
            let imageurl = self.photoDataString[indexPath.row] as! String
            if (imageurl != ""){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
                cell.photo_image.moa.url  = photoUrl(avatar: imageurl)
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addphotoCell", for: indexPath) as! AddPhotoCell
                
                return cell
            }
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "interestprofileCell", for: indexPath) as! InterestProfileCell
            if (indexPath.row < interestString.count) {
                  cell.interest_title.text = interestString[indexPath.row]
            }else{
                 let  bgselect_color = UIColor.init(red: 111/255, green: 91/255, blue: 218/255, alpha: 1.0)
                cell.interest_title.text = "Edit"
                cell.interest_title.textColor = bgselect_color
            }
          
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        if (sourceIndexPath.row < self.photoDataString.count && destinationIndexPath.row < self.photoDataString.count){
//            let temp = self.photoDataString.remove(at: sourceIndexPath.item)
//            self.photoDataString.insert(temp, at: destinationIndexPath.item)
//        }
//    }
}

extension EditProfileVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        if (collectionView == self.user_photoView) {
            return CGSize(width: (bounds.width - 25) / 3, height: (bounds.width - 25) / 3)
        }else{
            return CGSize(width: (bounds.width - 25) / 3, height: 30)
        }
    }
}
extension EditProfileVC: UICollectionViewDragDelegate,UICollectionViewDropDelegate{
   
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
      
        let item = self.photoDataString[indexPath.row]
        let itemprovider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemprovider)
        dragItem.localObject = item
        return [dragItem]
        
    }
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        var destinationIndexpath: IndexPath
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexpath = indexPath
        }else {
            let row = collectionView.numberOfItems(inSection: 0)
            destinationIndexpath = IndexPath(item: row - 1, section: 0)
        }
        if coordinator.proposal.operation == .move {
            self.reorderItems(coordinator: coordinator, destinationIndexpath: destinationIndexpath, collectionView: collectionView)
        }
    }
    fileprivate func reorderItems(coordinator: UICollectionViewDropCoordinator,destinationIndexpath: IndexPath, collectionView: UICollectionView) {
        if let item = coordinator.items.first,
            let sourceIndexPath = item.sourceIndexPath {
            
            collectionView.performBatchUpdates({
                self.photoDataString.remove(at: sourceIndexPath.item)
                self.photoDataString.insert(item.dragItem.localObject as! String, at: destinationIndexpath.item)
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexpath])
                
            },completion: nil)
            coordinator.drop(item.dragItem,toItemAt: destinationIndexpath)
        }
    }
}
