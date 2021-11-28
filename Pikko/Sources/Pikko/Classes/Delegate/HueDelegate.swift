//
//  HueDelegate.swift
//  Pikko
//
//  Created by Sandra & Johannes.
//

import Foundation
#if os(iOS)
import UIKit
#endif


/// Delegate used for writing back hue updates from the HueView.
internal protocol HueDelegate: AnyObject {
    func didUpdateHue(hue: CGFloat)
}
