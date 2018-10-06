//
//  SquareColorView.swift
//  Pikko_Example
//
//  Created by Sandra Grujovic on 05.10.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

public class BrightnessSaturationColorView: UIView {
    
    // FIXME: Make sampling rate parametric depending on size of canvas.
    var samplingRate: CGFloat = 25.0
    var colorPaletteView: UIView!
    var brightnessLayer: CAGradientLayer?
    var saturationLayer: CAGradientLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        saturationLayer = createSaturationLayer(hue: 0.0)
        brightnessLayer = createBrightnessLayer()
        
        layer.addSublayer(saturationLayer!)
        layer.addSublayer(brightnessLayer!)
    }
    
    public func updateColors(hue: CGFloat) {
        saturationLayer?.colors = generateSaturationInterpolationArray(hue: hue)
    }
    
    private func generateSaturationInterpolationArray(hue: CGFloat) -> [CGColor] {
        var colorArray = [CGColor]()
        
        for i in 0..<Int(samplingRate) {
            let interpolationValue = CGFloat(CGFloat(i) / samplingRate)
            let color = UIColor(hue: hue, saturation: interpolationValue, brightness: 1.0, alpha: 1.0)
            colorArray.append(color.cgColor)
        }
        
        return colorArray
    }
    
    private func createSaturationLayer(hue: CGFloat) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = generateSaturationInterpolationArray(hue: hue)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = bounds
        
        return gradientLayer
    }
    
    private func createBrightnessLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        var colorArray = [CGColor]()
        
        for i in 0..<Int(samplingRate) {
            let interpolationValue = CGFloat(CGFloat(i) / samplingRate)
            let color = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: interpolationValue)
            colorArray.append(color.cgColor)
        }
        
        gradientLayer.colors = colorArray
        gradientLayer.frame = bounds
        
        return gradientLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
