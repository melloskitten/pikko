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


class PikkoView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(holdPicker(_:)))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func holdPicker(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: self)
        setColorPickerPin(location: location, sourceView: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        setColorPickerPin(location: location, sourceView: self)
    }
    
    func setColorPickerPin(location: CGPoint, sourceView: UIView) {
        let color = getPixelColorAtPoint(point: location, sourceView: sourceView)
        
        print(color)
        //visualisationColorView.backgroundColor = color
        //visualisationColorView.center = location
    }
    
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
            
            pixel.deallocate(capacity: 4)
            
            return color
        }
        return nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

public class SquareColorView: UIView {
    
    var samplingRate: CGFloat = 25.0
    
    var visualisationColorView: UIView!
    var colorPaletteView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.colorPaletteView = UIView(frame: frame)
        self.visualisationColorView = UIView(frame: frame)
        
        createSaturationLayer()
        createBrightnessLayer()
        self.addSubview(colorPaletteView)
        self.addSubview(visualisationColorView)
        //visualisationColorView.backgroundColor = .blue
        //visualisationColorView.layer.borderWidth = 2
        visualisationColorView.layer.borderColor = UIColor.white.cgColor
    }
    
    func createSaturationLayer() {
        
        let fullGradient = UIView(frame: self.frame)
        
        let valueLayer = CAGradientLayer()
        var tempArray = [CGColor]()
        
        for i in 0..<Int(samplingRate) {
            let saturationValue = CGFloat(CGFloat(i) / samplingRate)
            let color = UIColor(hue: CGFloat(0)/255.0, saturation: saturationValue, brightness: 1.0, alpha: 1.0)
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
    
}




var liveView = PikkoView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
liveView.backgroundColor = .gray
let radius = liveView.frame.width/2
let borderWidth: CGFloat = 30.0


var hue = HueRingView(frame: liveView.frame, borderWidth: borderWidth)
// TODO: Parametrize all position information.

var customWidth: CGFloat = sqrt(2) * (radius - borderWidth)
var square = SquareColorView(frame: CGRect(x: 0, y: 0, width: customWidth, height: customWidth))
square.center = hue.center

liveView.addSubview(square)
liveView.addSubview(hue)


PlaygroundPage.current.liveView = liveView


