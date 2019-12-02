//
//  Pikko.swift
//  Pikko
//
//  Created by Sandra & Johannes.
//

import Foundation
#if os(iOS)
import UIKit

/// The Pikko colorpicker, holding the two subviews, namely the hue ring and brightness/saturation
/// square picker.
@IBDesignable
@available(iOS 9.0, *)
public class Pikko: UIView {
    
    private var hueView: HueView?
    private var brightnessSaturationView: BrightnessSaturationView?
    private var currentColor: UIColor = .white
    public var dimension: Int = 0

    
    /// The PikkoDelegate that is called whenever the color is updated.
    public var delegate: PikkoDelegate?
    
    // MARK: - Initializer.

    /// Initializes a new PikkoView.
    ///
    /// - Parameters:
    ///     - dimension: width and heigth of the new color picker.
    ///     - color: the color you want to initialise the picker to. If not set, the color picker
    ///     is initialised to `UIColor.white`.
    public init(dimension: Int, setToColor color: UIColor = .white) {
        let frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        super.init(frame: frame)
        self.dimension = dimension
        self.currentColor = color
        setUpColorPickerViews(frame)
        setColor(color)
        self.widthAnchor.constraint(equalToConstant: CGFloat(dimension)).isActive = true
        self.heightAnchor.constraint(equalToConstant: CGFloat(dimension)).isActive = true
    }
    
    /// This constructor is necessary for the interface builder rendering,
    /// and should not be called by application programmers. Use
    /// `init(dimension: Int, setToColor color: UIColor)` instead.
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.dimension = Int(frame.width)
        setUpColorPickerViews(frame)
    }
    
    /// This method is called when resizing or moving the picker
    /// in the interface builder.
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.brightnessSaturationView?.removeFromSuperview()
        self.hueView?.removeFromSuperview()
        let newFrame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        setUpColorPickerViews(newFrame)
        setColor(currentColor)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Helper methods.
    
    /// Initialises both hueView and brightnessSaturationView.
    /// - TODO: Many constants are hardcoded. Make them adjustable with customised initialisers
    /// in the future.
    /// - TODO: Make borderwidth an adjustable parameter.
    /// - TODO: Explain magic constant that controls "margin" of the square.
    private func setUpColorPickerViews(_ frame: CGRect) {
        
        let borderWidth: CGFloat = 30.0
        let selectorDiameter: CGFloat = borderWidth * 1.5
        let radius = frame.width/2
        
        let customWidth: CGFloat = sqrt(2) * (radius - borderWidth) * 0.85
        let scale: CGFloat = 1.5
        
        hueView = HueView(frame: frame, borderWidth: borderWidth,
                          selectorDiameter: selectorDiameter,
                          scale: scale)
        
        brightnessSaturationView = BrightnessSaturationView(frame: CGRect(x: 0,
                                                                          y: 0,
                                                                          width: customWidth,
                                                                          height: customWidth),
                                                            selectorDiameter: selectorDiameter,
                                                            scale: 2)
        
        if let hue = hueView, let square = brightnessSaturationView {
            hue.delegate = self
            square.delegate = self
            square.center = hue.center
            self.addSubview(hue)
            self.addSubview(square)

        }
    }
    
    /// Gets the current color that is selected on the color picker.
    ///
    /// - Returns: the current color.
    public func getColor() -> UIColor {
        return currentColor
    }
    
    
    /// Sets the color picker to the specified color.
    ///
    /// - Parameter color: the color to set on the color picker.
    public func setColor(_ color: UIColor) {
        if let hue = hueView, let square = brightnessSaturationView {
            hue.setColor(color)
            square.setColor(color)
        }
    }
}

// MARK: HueDelegate methods.

@available(iOS 9.0, *)
extension Pikko: HueDelegate {
    func didUpdateHue(hue: CGFloat) {
        if let square = brightnessSaturationView {
            square.didUpdateHue(hue: hue)
        }
    }
}

// MARK: PikkoDelegate methods.

@available(iOS 9.0, *)
extension Pikko: PikkoDelegate {
    public func writeBackColor(color: UIColor) {
        currentColor = color
        if let delegate = delegate {
            delegate.writeBackColor(color: color)
        }
    }
}

#endif
