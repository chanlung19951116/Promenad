//
//  MatchVC.swift
//  Promenad
//
//  Created by LiuYan on 8/2/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import UIKit
import Koloda
import SwiftGifOrigin
import NVActivityIndicatorView
import Pulsator
class MatchVC: UIViewController {
    
    var kolodaView: KolodaView!
    var images : [UIImage] = [UIImage(named: "match_image")!,UIImage(named: "match_image2")!,UIImage(named: "match_image")!,UIImage(named: "match_image2")!,UIImage(named: "match_image")!,UIImage(named: "match_image2")!]
    
    fileprivate var dataSource: [UIImage] = {
        var array: [UIImage] = []
        for index in 0..<6 {
            array.append(UIImage(named: "match_image")!)
        }
        
        return array
    }()
    var pulsator : [Pulsator] = [Pulsator(),Pulsator(),Pulsator(),Pulsator(),Pulsator(),Pulsator()]
    override func viewDidLoad() {
        if DeviceType.iPhoneX {
             kolodaView = KolodaView(frame: CGRect(x: 20, y: 120, width: self.view.frame.width - 40, height: self.view.frame.height - 240))
        }else {
             kolodaView = KolodaView(frame: CGRect(x: 20, y: 80, width: self.view.frame.width - 40, height: self.view.frame.height - 160))
        }
       
        self.view.addSubview(kolodaView)
        
        kolodaView.dataSource = self
        kolodaView.delegate = self
        kolodaView.layer.cornerRadius = 10
        kolodaView.layer.masksToBounds = true
        initUI()
    }
    func initUI(){
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        let leafimage = UIImage(named: "leaf")!
        let notificationimage = UIImage(named: "notification")!
        
        let leafBtn: UIButton = UIButton(type: UIButton.ButtonType.custom) as! UIButton
        leafBtn.setImage(leafimage, for: .normal)
        leafBtn.addTarget(self, action: #selector(Leaf_Action), for: .touchUpInside)
        leafBtn.frame = CGRect(origin : CGPoint(x:-10, y:0), size: CGSize(width: 20, height: 30))
        let leafbaritem = UIBarButtonItem(customView: leafBtn)
        
        let leaflabel = UILabel(frame: CGRect(x: 20, y: 0, width: 20, height: 30))
        leaflabel.text = "100"
        let text_color = UIColor.init(red: 70/255, green: 69/255, blue: 77/255, alpha: 1.0)
        leaflabel.textColor = text_color
        let leafbarseconditem = UIBarButtonItem(customView: leaflabel)
        
        
        let leaflabel1 = UILabel(frame: CGRect(x: 20, y: 0, width: 20, height: 30))
        let leafbarseconditem1 = UIBarButtonItem(customView: leaflabel1)
        
        let noti_btn: UIButton = UIButton(type: UIButton.ButtonType.custom) as! UIButton
        noti_btn.setImage(notificationimage, for: .normal)
        noti_btn.addTarget(self, action: #selector(Notification), for: .touchUpInside)
        noti_btn.frame = CGRect(origin : CGPoint(x:-10, y:0), size: CGSize(width: 20, height: 30))
        let notiBtn = UIBarButtonItem(customView: noti_btn)
        self.navigationItem.setRightBarButtonItems([notiBtn,leafbarseconditem1], animated: false)
        self.navigationItem.setLeftBarButtonItems([leafbaritem,leafbarseconditem], animated: false)
        
        
        
        let logo_image = UIImage(named: "logo_small")
        let imageView = UIImageView(image:logo_image)
        navigationItem.titleView = imageView
        
    }
    @objc func Leaf_Action(){
        let leafDialog = LeafDialog(title: "", vc: self)
        leafDialog.show(animated: true)
    }
    @objc func Notification(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "assistantVC") as! AssistantVC
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
}
extension MatchVC: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        for index in 0..<6 {
            self.dataSource.append(UIImage(named: "match_image")!)
        }
        self.kolodaView.reloadData()
        
    }
   
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        //self.pulsator[index].start()
       // UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "detailVC") as! DetailVC
        // self.present(verificationController, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func koloda(_ koloda: KolodaView, shouldDragCardAt index: Int) -> Bool {
        print("drage")
        self.pulsator[index].start()
        return true
    }
    
    
}
extension MatchVC: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return dataSource.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let cus_view = UIView(frame: CGRect(x: 20, y: 100, width: self.kolodaView.frame.width, height: self.kolodaView.frame.height))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cus_view.frame.width, height: cus_view.frame.height))
        imageView.image = UIImage(named: "match_image")
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        cus_view.addSubview(imageView)
        let subView = UIView(frame: CGRect(x: 0, y: cus_view.frame.height - 120, width: cus_view.frame.width, height: 120))
        let nameLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
        nameLabel.text = "Anna, 26"
        nameLabel.font = UIFont.systemFont(ofSize: 17)
        nameLabel.numberOfLines = 0
        var maximumLabelSize: CGSize = CGSize(width: 280, height: 9999)
        var expectedLabelSize: CGSize = nameLabel.sizeThatFits(maximumLabelSize)
        // create a frame that is filled with the UILabel frame data
        
        var newFrame: CGRect = nameLabel.frame
        // resizing the frame to calculated size
        newFrame.size.height = expectedLabelSize.height
        // put calculated frame into UILabel frame
        nameLabel.frame = newFrame
        subView.addSubview(nameLabel)
        let onlineimageView = UIImageView(frame: CGRect(x: nameLabel.frame.width, y: 10 + nameLabel.frame.height / 4, width: 10, height: 10))
        onlineimageView.image = UIImage(named: "online")
        subView.addSubview(onlineimageView)
        let location_image = UIImageView(frame: CGRect(x: 10, y: nameLabel.frame.height + 15, width: 15, height: 15))
        location_image.image = UIImage(named: "ic_location")
        subView.addSubview(location_image)
        let distance_label = UILabel(frame: CGRect(x: 25, y: nameLabel.frame.height + 15, width: 200, height: 20))
        distance_label.text = "1.3 km away"
        distance_label.font = UIFont.systemFont(ofSize: 8)
        distance_label.textColor = UIColor.lightGray
        subView.addSubview(distance_label)
        
        
        let explain_lbl = UILabel(frame: CGRect(x: 10, y: nameLabel.frame.height + 40, width: subView.frame.width - 30, height: 40))
        explain_lbl.text = "Wanna find somebody for a night walk today evening"
        explain_lbl.font = UIFont.systemFont(ofSize: 14)
        explain_lbl.numberOfLines = 0
        var maximumLabelSize1: CGSize = CGSize(width: 280, height: 9999)
        var expectedLabelSize1: CGSize = explain_lbl.sizeThatFits(maximumLabelSize1)
        // create a frame that is filled with the UILabel frame data
        var newFrame1: CGRect = explain_lbl.frame
        // resizing the frame to calculated size
        newFrame.size.height = expectedLabelSize1.height
        // put calculated frame into UILabel frame
        explain_lbl.frame = newFrame1
        subView.addSubview(explain_lbl)
        
        subView.backgroundColor = UIColor.white
        cus_view.addSubview(subView)
        let imagView =  UIImageView(frame: CGRect(x: cus_view.frame.width - 60, y: cus_view.frame.height - 145, width: 50, height: 50))
        imagView.image = UIImage(named: "ic_like")
        imageView.contentMode = .scaleToFill
        let gifview = UIView(frame: CGRect(x: cus_view.frame.width - 35, y: cus_view.frame.height - 120, width: 1, height: 1))
      
        self.pulsator[index].radius = 50
        self.pulsator[index].numPulse = 10
        self.pulsator[index].backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        gifview.layer.addSublayer(self.pulsator[index])
       
        cus_view.addSubview(gifview)
        cus_view.addSubview(imagView)
        
        return cus_view
    }
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        self.pulsator[index].start()
    }
    func koloda(_ koloda: KolodaView, draggedCardWithPercentage finishPercentage: CGFloat, in direction: SwipeResultDirection) {
        
    }
    
    
//    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
//        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
//    }
}
