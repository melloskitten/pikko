import PlaygroundSupport
import UIKit
import Foundation


public class HueRingView: UIView {
    
    var offset = CGFloat(200)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        for i in 0..<255 {
            
            let layer = CALayer()
            layer.backgroundColor = UIColor(hue: CGFloat(i)/255.0, saturation: 1.0, brightness: 1.0, alpha: 1.0).cgColor
            
            let radius = CGFloat(150)
            
            let position = (CGFloat(i) / 255.0) * 360.0
            
            let position_y = sin(position * CGFloat.pi / 180.0) * radius
            let position_x = cos(position * CGFloat.pi / 180.0) * radius
            layer.frame = CGRect(x: position_y+offset, y: position_x+offset, width: 5, height: 40)
            
            layer.transform = CATransform3DMakeRotation(-(position*CGFloat.pi)/180.0, 0, 0, 1.0)
            
            layer.allowsEdgeAntialiasing = true
            
            self.layer.addSublayer(layer)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
