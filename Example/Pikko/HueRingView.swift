//
//  HueRingView.swift
//  Pikko_Example
//
//  Created by Sandra Grujovic on 05.10.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class HueRingView: UIView {
    
    private var offset_x: CGFloat = 0.0
    private var offset_y: CGFloat = 0.0
    private var radius: CGFloat
    private var borderWidth: CGFloat
    private var borderHeight: CGFloat
    private var selector: UIView?
    private var hueRing: UIView?
    private var scale: CGFloat
    
    init(frame: CGRect, borderWidth: CGFloat, scale: CGFloat) {
        self.borderWidth = borderWidth
        // FIXME: Currently hardcoded borderHeight.
        self.borderHeight = 5
        self.radius = (frame.width-borderWidth)/2
        self.scale = scale
        self.offset_x = (frame.width-borderWidth)/2
        self.offset_y = (frame.height-borderHeight)/2
        super.init(frame: frame)
        
        createHueRing()
        createSelector()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSelector() {
        selector = UIView(frame: CGRect(x: 0, y: 0, width: borderWidth * scale, height: borderWidth*scale))
        selector?.center = CGPoint(x: (borderWidth)/2, y: offset_y)
        selector?.layer.cornerRadius = (borderWidth * scale)/2
        selector?.isUserInteractionEnabled = true
        selector?.layer.borderWidth = 1
        selector?.layer.borderColor = UIColor.white.cgColor
        updateColor(point: (selector?.center)!)
        setUpGestureRecognizer()
        
        self.addSubview(selector!)
    }
    
    private func setUpGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(selectorPanned(_:)))
        selector?.addGestureRecognizer(panGestureRecognizer)
    }

    @objc func selectorPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let location = panGestureRecognizer.location(in: self)

        let x = location.x - center.x
        let y = location.y - center.y
        let angle = atan2(x, y) - CGFloat.pi * 0.5
        
        let position_y = sin(-1.0 * angle) * radius + center.x
        let position_x = cos(-1.0 * angle) * radius + center.y
        
        selector?.center = CGPoint(x: position_x, y: position_y)
        updateColor(point: (selector?.center)!)
    }
    
    private func updateColor(point: CGPoint) {
        selector?.backgroundColor = ColorUtilities.getPixelColorAtPoint(point: point, sourceView: hueRing!)
    }
    
    private func createHueRing() {
        hueRing = UIView(frame: self.frame)
        
        for i in 0..<255 {
            let layer = CALayer()
            layer.backgroundColor = UIColor(hue: CGFloat(i)/255.0, saturation: 1.0, brightness: 1.0, alpha: 1.0).cgColor
            
            let position = (CGFloat(i) / 255.0) * 360.0
            let position_y = sin(position * CGFloat.pi / 180.0) * radius
            let position_x = cos(position * CGFloat.pi / 180.0) * radius
            
            layer.frame = CGRect(x: position_x+offset_x, y: position_y+offset_y, width: borderWidth, height: borderHeight)
            layer.transform = CATransform3DMakeRotation((position*CGFloat.pi)/180.0, 0, 0, 1.0)
            layer.allowsEdgeAntialiasing = true
            
            hueRing!.layer.addSublayer(layer)
        }

        addSubview(hueRing!)
    }
}
