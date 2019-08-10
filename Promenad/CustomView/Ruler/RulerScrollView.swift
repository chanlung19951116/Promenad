//
//  RulerScrollView.swift
//  Promenad
//
//  Created by LiuYan on 8/1/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import Foundation
import UIKit
enum RulerDirection:Int{
    case Horizontal = 0
    case Vertical = 1
}

protocol RulerScrollViewDelegate{
    func rulerScrollViewValueChanged(rulerScrollView: RulerScrollView, value: CGFloat)
}

class RulerScrollView: UIScrollView, UIScrollViewDelegate {
    //Options
    private var rulerScrollViewDelegate: RulerScrollViewDelegate? = nil
    private var direction: RulerDirection = RulerDirection.Vertical
    private var totalUnitCount: Int = 100
    private var unitStartNumber: Int = 100
    private var imageNameForOneUnit: String = "unit"
    private var unitString: String = "CM"
    private var autoAlignToCloseInt: Bool = false
    private var initUnitPosition: Int = 150
    //Options
    
    
    private var unitEdge: CGFloat = 0
    private var UIInited = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initRuler(rulerDelegate: RulerScrollViewDelegate, imageNameForUnit: String, rulerDirection: RulerDirection=RulerDirection.Vertical, rulerTotalUnitCount: Int=100, rulerUnitStartNumber: Int=100, rulerInitUnitPosition: Int=150, rulerUnitString: String="cm", rulerAutoAlignToCloseInt: Bool = false){
        
        rulerScrollViewDelegate = rulerDelegate
        direction = rulerDirection
        totalUnitCount = rulerTotalUnitCount
        unitStartNumber = rulerUnitStartNumber
        initUnitPosition = rulerInitUnitPosition
        unitString = rulerUnitString
        imageNameForOneUnit = imageNameForUnit
        autoAlignToCloseInt = rulerAutoAlignToCloseInt
        
    }
    
    private func initUI(){
        if UIInited {
            return
        }
        UIInited = true
        
        self.delegate = self
        
        let labelWidth: CGFloat = 50
        let labelHeight: CGFloat = 20
        var lblCenterPoint: CGFloat = 0
        var startPoint: CGFloat = 0
        
        if direction == .Vertical { // Edge as width
            unitEdge = self.frame.width
            lblCenterPoint = unitEdge - labelWidth/2.0
            startPoint = self.bounds.height / 2.0
        } else { // Edge as Height
            unitEdge = self.frame.height
            lblCenterPoint = unitEdge - labelHeight/2.0
            startPoint = self.bounds.width / 2.0
        }
        
        
        if let _ = UIImage(named: imageNameForOneUnit){ //Check Image Exists
            for i in 0..<totalUnitCount {
                if let img = UIImage(named: imageNameForOneUnit){ //Build Image & Label Array
                    
                    let imgv = UIImageView(image: img)
                    let lbl = UILabel(frame: CGRect(x:0, y:0, width: labelWidth, height: labelHeight))
                    lbl.backgroundColor = UIColor.clear
                    lbl.textAlignment = NSTextAlignment.center
                    lbl.font = UIFont.systemFont(ofSize: 12)
                    lbl.adjustsFontSizeToFitWidth = true
                    lbl.minimumScaleFactor = 0.5
                    lbl.textColor = UIColor.black
                    let coor = CGFloat(i) * unitEdge + startPoint
                    if direction == .Vertical {
                        imgv.frame = CGRect(x:0, y:coor, width: unitEdge, height: unitEdge)
                        lbl.center = CGPoint(x: lblCenterPoint, y:coor)
                    } else {
                        imgv.frame = CGRect(x: coor, y: 0, width: unitEdge, height: unitEdge)
                        lbl.center = CGPoint(x: coor, y: lblCenterPoint)
                    }
                    lbl.text = String(format: "%d %@", (unitStartNumber+i), unitString)
                    if i != totalUnitCount { //Last one no need to add image
                        self.addSubview(imgv)
                    }
                    self.addSubview(lbl)
                }
            }
            
            var startPos = initUnitPosition - unitStartNumber
            
            if startPos < 0{
                startPos = 0
            }
            if direction == .Vertical {
                self.contentSize = CGSize(width: self.frame.width, height: CGFloat(totalUnitCount) * unitEdge + self.frame.height)
                self.setContentOffset(CGPoint(x:0, y: CGFloat(startPos) * unitEdge), animated: false)
            } else {
                self.contentSize = CGSize(width: CGFloat(totalUnitCount) * unitEdge + self.frame.width, height: self.frame.height)
                self.setContentOffset(CGPoint(x: CGFloat(startPos) * unitEdge, y: 0), animated: false)
            }
        }
        
    }
    
    func moveToCloseInt() {
        if !autoAlignToCloseInt {
            return
        }
        var targetPixel: CGFloat = 0.0
        if direction == .Vertical {
            targetPixel = CGFloat(roundf(Float(self.contentOffset.y / unitEdge))) * unitEdge
            self.setContentOffset(CGPoint(x: self.contentOffset.x, y: targetPixel), animated: true)
            
        } else {
            targetPixel = CGFloat(roundf(Float(self.contentOffset.x / unitEdge))) * unitEdge
            self.setContentOffset(CGPoint(x: targetPixel, y: self.contentOffset.y), animated: true)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.initUI()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var value: CGFloat = 0.0
        if direction == .Vertical {
            value = self.contentOffset.y / unitEdge
        } else {
            value = self.contentOffset.x / unitEdge
        }
        value += CGFloat(unitStartNumber)
        if let rulerDelegate = rulerScrollViewDelegate {
            rulerDelegate.rulerScrollViewValueChanged(rulerScrollView: self, value: value)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.moveToCloseInt()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.moveToCloseInt()
    }
}
