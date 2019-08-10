//
//  FeedDurationFormatter.swift
//  Promenad
//
//  Created by LiuYan on 8/8/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import Foundation
class FeedDurationFormatter: NumberFormatter {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init() {
        super.init()
        self.locale = NSLocale.current
    }
    
    override func string(from duration: NSNumber) -> String? {
        let duration = duration.intValue
        // time string, we don't want the decimals
        let timeString = String(duration) as! String
        return timeString + " lbs"
    }
    
    // Swift 1.2 or above
    static let sharedInstance = FeedDurationFormatter()
}
