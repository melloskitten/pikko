//
//  PikkoDelegate.swift
//  Pikko
//
//  Created by Sandra & Johannes.
//

import Foundation
#if os(iOS)
import UIKit

/// Delegate which propagates color changes of the colorpicker to its delegate.
public protocol PikkoDelegate: AnyObject {
    func writeBackColor(color: UIColor)
}

#endif
