//
//  Length.swift
//  Promenad
//
//  Created by LiuYan on 8/1/19.
//  Copyright © 2019 LiuYan. All rights reserved.
//

import Foundation
import UIKit
class Length {
    
    // MARK: - Types
    enum Unit {
        case centimeter
        case inch
    }
    // MARK: - Constants
    private struct Constants {
        static let pixelInCentimetre : CGFloat = 80
        static let pixelInInch : CGFloat = 200
    }
    
    // MARK: - Convenience
    static func pixels(fromInch value: CGFloat) ->CGFloat {
        return value * Constants.pixelInInch
    }
    
    static func pixels(fromCentimeter value: CGFloat) ->CGFloat {
        return value * Constants.pixelInCentimetre
    }
    
    static func inch(fromPixels value: CGFloat) ->CGFloat {
        return value / Constants.pixelInInch
    }
    
    static func centimeter(fromPixels value: CGFloat) ->CGFloat {
        return value / Constants.pixelInCentimetre
    }
}
