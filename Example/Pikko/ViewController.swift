//
//  ViewController.swift
//  Pikko_Example
//
//  Created by Sandra & Johannes
//

import UIKit
import Pikko

/// Example UIViewController that demonstrates Pikko.
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1.0) 
        
        // Initialize a new Pikko instance.
        let pikko = Pikko(dimension: 300, setToColor: .blue)
        
        // Set the PikkoDelegate to get notified on new color changes.
        pikko.delegate = self

        // Set Pikko center and add it to the main view.
        pikko.center = self.view.center
        self.view.addSubview(pikko)
        
        // Get the current color.
        _ = pikko.getColor()
    }
}

// MARK: - PikkoDelegate methods.

extension ViewController: PikkoDelegate {
    
    /// This method gets called whenever the pikko color was updated.
    func writeBackColor(color: UIColor) {
        print("New color: \(color)")
    }
}
