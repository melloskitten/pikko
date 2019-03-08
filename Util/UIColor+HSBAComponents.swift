//
//  UIColor+HSBAComponents.swift
//  Pikko
//
//  Created by Sandra Grujovic on 07.03.19.
//

import Foundation

extension UIColor {
    fileprivate func getHSBAComponents(_ color: UIColor) -> (CGFloat, CGFloat, CGFloat, CGFloat) {
        var hue, saturation, brightness, alpha : CGFloat
        (hue, saturation, brightness, alpha) = (0.0, 0.0, 0.0, 0.0)
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return (hue, saturation, brightness, alpha)
    }
    
    var hue: CGFloat {
        return getHSBAComponents(self).0
    }
    
    var saturation: CGFloat {
        return getHSBAComponents(self).1
    }
    
    var brightness: CGFloat {
        return getHSBAComponents(self).2
    }
    
    var alpha: CGFloat {
        return getHSBAComponents(self).3
    }
}
