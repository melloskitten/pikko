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
        
        setUpGestureRecognizer()
    }
    
    fileprivate func setUpColorPickerViews(_ frame: CGRect) {
        // TODO: Make borderwidth an adjustable parameter.
        let borderWidth: CGFloat = 30.0
        let radius = frame.width/2
        let customWidth: CGFloat = sqrt(2) * (radius - borderWidth)
        
        hue = HueRingView(frame: frame, borderWidth: borderWidth)
        square = BrightnessSaturationColorView(frame: CGRect(x: 0, y: 0, width: customWidth, height: customWidth))
        
        square!.center = hue!.center
        
        self.addSubview(hue!)
        self.addSubview(square!)
    }
    
    fileprivate func setUpGestureRecognizer() {
        self.isUserInteractionEnabled = true
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(holdPicker(_:)))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func holdPicker(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self)
        updateSaturationBrightnessColorView(location: location, sourceView: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        updateSaturationBrightnessColorView(location: location, sourceView: self)
    }
    
    func updateSaturationBrightnessColorView(location: CGPoint, sourceView: UIView) {
        let color = getPixelColorAtPoint(point: location, sourceView: sourceView)
        
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        color!.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        self.square?.updateColors(hue: h)
    }
    
    // TAKEN FROM: https://stackoverflow.com/a/27746860/7217195
    func getPixelColorAtPoint(point:CGPoint, sourceView: UIView) -> UIColor? {
        let pixel = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        var color: UIColor? = nil
        
        if let context = context {
            context.translateBy(x: -point.x, y: -point.y)
            self.layer.render(in: context)
            
            color = UIColor(red: CGFloat(pixel[0])/255.0,
                            green: CGFloat(pixel[1])/255.0,
                            blue: CGFloat(pixel[2])/255.0,
                            alpha: CGFloat(pixel[3])/255.0)
            
            pixel.deallocate()
            
            return color
        }
        return nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
