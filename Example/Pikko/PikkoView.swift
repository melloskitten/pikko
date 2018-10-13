//
//  PikkoView.swift
//  Pikko_Example
//
//  Created by Sandra Grujovic on 05.10.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class PikkoView: UIView {
    
    var hue: HueRingView?
    var square: BrightnessSaturationColorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpColorPickerViews(frame)
        //setUpGestureRecognizer()
    }
    
    fileprivate func setUpColorPickerViews(_ frame: CGRect) {
        // TODO: Make borderwidth an adjustable parameter.
        let borderWidth: CGFloat = 30.0
        let radius = frame.width/2
        let customWidth: CGFloat = sqrt(2) * (radius - borderWidth)
        let scale: CGFloat = 1.5
        
        backgroundColor = .gray
        
        hue = HueRingView(frame: frame, borderWidth: borderWidth, scale: scale)
        square = BrightnessSaturationColorView(frame: CGRect(x: 0, y: 0, width: customWidth, height: customWidth), borderWidth: borderWidth, scale: scale)
        
        square!.center = hue!.center
        
        self.addSubview(hue!)
        self.addSubview(square!)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

