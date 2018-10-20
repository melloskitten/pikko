//
//  Animations.swift
//  Pikko_Example
//
//  Created by Sandra Grujovic on 15.10.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class Animations {
    
    public static func animateScale(view: UIView, byScale: CGFloat) {
        UIView.animate(withDuration: 0.25) {
            view.transform = CGAffineTransform(scaleX: byScale,y: byScale)
        }
    }
    
    public static func animateScaleReset(view: UIView) {
        UIView.animate(withDuration: 0.25) {
            view.transform = CGAffineTransform(scaleX: 1,y: 1)
        }
    }
}
