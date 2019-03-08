//
//  HueView.swift
//  Pikko
//
//  Created by Sandra & Johannes.
//

import UIKit

internal class HueView: UIView {
    
    private var offset_x: CGFloat = 0.0
    private var offset_y: CGFloat = 0.0
    private var radius: CGFloat
    private var borderWidth: CGFloat
    private var borderHeight: CGFloat
    private var selector: UIView?
    private var selectorDiameter: CGFloat
    private var hueRingView: UIView?
    private var scale: CGFloat
    public var delegate: HueDelegate?
    
    init(frame: CGRect, borderWidth: CGFloat, selectorDiameter: CGFloat, scale: CGFloat) {
        self.borderWidth = borderWidth
        // FIXME: Currently hardcoded borderHeight.
        self.borderHeight = 5
        self.radius = (frame.width-borderWidth)/2
        self.scale = scale
        self.offset_x = (frame.width-borderWidth)/2
        self.offset_y = (frame.height-borderHeight)/2
        self.selectorDiameter = selectorDiameter
        super.init(frame: frame)
        
        createHueRing()
        createSelector()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSelector() {
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorDiameter, height: selectorDiameter))
        selector?.center = CGPoint(x: (borderWidth)/2, y: offset_y)
        selector?.layer.cornerRadius = (selectorDiameter)/2
        selector?.isUserInteractionEnabled = true
        selector?.layer.borderWidth = 1
        selector?.layer.borderColor = UIColor.white.cgColor
        updateColor(point: (selector?.center)!)
        setUpGestureRecognizer()
        
        self.addSubview(selector!)
    }
    
    private func setUpGestureRecognizer() {
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(selectorPanned(_:)))
        longPressGestureRecognizer.minimumPressDuration = 0.0
        selector?.addGestureRecognizer(longPressGestureRecognizer)
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
        animate(panGestureRecognizer)
    }
    
    private func animate(_ panGestureRecognizer: UIPanGestureRecognizer) {
        switch panGestureRecognizer.state {
        case .began:
            Animations.animateScale(view: selector!, byScale: scale)
        case .ended:
            Animations.animateScaleReset(view: selector!)
        default:
            break
        }
    }
    
    private func updateColor(point: CGPoint) {
        var hue: CGFloat = 0
        
        if let color = ColorUtilities.getPixelColorAtPoint(point: point, sourceView: hueRingView!), let selector = selector {
            selector.backgroundColor = color
            color.getHue(&hue, saturation: nil, brightness: nil, alpha: nil)
            delegate?.didUpdateHue(hue: hue)
        }
    }
    
    private func createHueRing() {
        hueRingView = UIView(frame: self.frame)
        
        for i in 0..<255 {
            let layer = CALayer()
            layer.backgroundColor = UIColor(hue: CGFloat(i)/255.0, saturation: 1.0, brightness: 1.0, alpha: 1.0).cgColor
            
            let position = (CGFloat(i) / 255.0) * 360.0
            let position_y = sin(position * CGFloat.pi / 180.0) * radius
            let position_x = cos(position * CGFloat.pi / 180.0) * radius
            
            layer.frame = CGRect(x: position_x+offset_x, y: position_y+offset_y, width: borderWidth, height: borderHeight)
            layer.transform = CATransform3DMakeRotation((position*CGFloat.pi)/180.0, 0, 0, 1.0)
            layer.allowsEdgeAntialiasing = true
            
            hueRingView!.layer.addSublayer(layer)
        }

        addSubview(hueRingView!)
    }
    
    
    /// Sets the hue selector to a certain color.
    ///
    /// - Parameter color: UIColor for the selector position.
    func setColor(_ color: UIColor) {
        let angle = color.hue
        
        let position_y = sin(1.0 * angle * 2 * CGFloat.pi) * radius + center.x
        let position_x = cos(1.0 * angle * 2 * CGFloat.pi) * radius + center.y
        let newCenter = CGPoint(x: position_x, y: position_y)
        
        selector?.center = newCenter
        updateColor(point: newCenter)
    }
}
