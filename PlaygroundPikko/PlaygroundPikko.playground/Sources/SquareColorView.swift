import Foundation
import UIKit
import PlaygroundSupport

/*public class SquareColorView: UIView {
    
    var samplingRate: CGFloat = 25.0
    //var visualisationColorView: UIView!
    var colorPaletteView: UIView!
    var hue: CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.colorPaletteView = UIView(frame: frame)
        //self.visualisationColorView = UIView(frame: frame)
        
        createSaturationLayer(hue: hue)
        createBrightnessLayer()
        self.addSubview(colorPaletteView)
        //self.addSubview(visualisationColorView)
        //visualisationColorView.backgroundColor = .blue
        //visualisationColorView.layer.borderWidth = 2
        //visualisationColorView.layer.borderColor = UIColor.white.cgColor
    }
    
    func createSaturationLayer(hue: CGFloat) {
        
        let fullGradient = UIView(frame: self.frame)
        
        let valueLayer = CAGradientLayer()
        var tempArray = [CGColor]()
        
        for i in 0..<Int(samplingRate) {
            let saturationValue = CGFloat(CGFloat(i) / samplingRate)
            let color = UIColor(hue: hue/255.0, saturation: saturationValue, brightness: 1.0, alpha: 1.0)
            tempArray.append(color.cgColor)
        }
        
        valueLayer.colors = tempArray
        valueLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        valueLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        valueLayer.frame = fullGradient.bounds
        
        fullGradient.layer.addSublayer(valueLayer)
        
        colorPaletteView.addSubview(fullGradient)
    }
    
    func createBrightnessLayer() {
        let sampledGradient = UIView(frame: self.frame)
        let smallValueLayer = CAGradientLayer()
        var smallTempArray = [CGColor]()
        
        for i in 0..<Int(samplingRate) {
            let saturationValue = CGFloat(CGFloat(i) / samplingRate)
            let color = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: saturationValue)
            smallTempArray.append(color.cgColor)
        }
        
        smallValueLayer.colors = smallTempArray
        smallValueLayer.frame = sampledGradient.bounds
        
        sampledGradient.layer.addSublayer(smallValueLayer)
        
        colorPaletteView.addSubview(sampledGradient)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}*/
