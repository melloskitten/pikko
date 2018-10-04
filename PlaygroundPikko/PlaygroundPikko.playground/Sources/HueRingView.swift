import PlaygroundSupport
import UIKit
import Foundation

class HueRingView: UIView {
    
    var offset_x: CGFloat = 0.0
    var offset_y: CGFloat = 0.0
    var radius: CGFloat
    var borderWidth: CGFloat
    var borderHeight: CGFloat
    
    init(frame: CGRect, borderWidth: CGFloat) {
        self.borderWidth = borderWidth
        // FIXME: Currently hardcoded borderHeight.
        self.borderHeight = 5
        self.radius = (frame.width-borderWidth)/2
        super.init(frame: frame)
        self.offset_x = (frame.width-borderWidth)/2
        self.offset_y = (frame.height-borderHeight)/2
        createHueRing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createHueRing() {
        for i in 0..<255 {
            let layer = CALayer()
            layer.backgroundColor = UIColor(hue: CGFloat(i)/255.0, saturation: 1.0, brightness: 1.0, alpha: 1.0).cgColor
            
            let position = (CGFloat(i) / 255.0) * 360.0
            let position_y = sin(position * CGFloat.pi / 180.0) * radius
            let position_x = cos(position * CGFloat.pi / 180.0) * radius
            
            layer.frame = CGRect(x: position_x+offset_x, y: position_y+offset_y, width: borderWidth, height: borderHeight)
            layer.transform = CATransform3DMakeRotation((position*CGFloat.pi)/180.0, 0, 0, 1.0)
            layer.allowsEdgeAntialiasing = true
            
            self.layer.addSublayer(layer)
        }
    }
}
