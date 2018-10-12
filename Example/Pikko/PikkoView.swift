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
        
        hue = HueRingView(frame: frame, borderWidth: borderWidth, scale: 1.5)
        square = BrightnessSaturationColorView(frame: CGRect(x: 0, y: 0, width: customWidth, height: customWidth))
        
        square!.center = hue!.center
        
        self.addSubview(hue!)
        self.addSubview(square!)
    }
    
    /*fileprivate func setUpGestureRecognizer() {
        self.isUserInteractionEnabled = true
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(holdPicker(_:)))
        self.addGestureRecognizer(gestureRecognizer)
    }*/
    
    
    /*func updateSaturationBrightnessColorView(location: CGPoint, sourceView: UIView) {
        let color = ColorUtilities.getPixelColorAtPoint(point: location, sourceView: sourceView)
        
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        color!.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        self.square?.updateColors(hue: h)
    }*/
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
