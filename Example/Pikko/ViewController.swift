//
//  ViewController.swift
//  Pikko
//
//  Created by Sandra on 09/18/2018.
//  Copyright (c) 2018 Sandra. All rights reserved.
//

import UIKit
import Pikko

/// Example UIViewController that demonstrates Pikko.
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1.0) 
        
        // Initialize a new instance of a PikkoView.
        let pikko = Pikko(dimension: 300)
        
        // Set the PikkoDelegate to get notified on new color changes.
        pikko.delegate = self

        // Set PikkoView center and add it to the main view.
        pikko.center = self.view.center
        self.view.addSubview(pikko)
        
        let color = UIColor.blue
        
        pikko.setColor(color)
    }
}

// MARK: - PikkoDelegate methods.

extension ViewController: PikkoDelegate {
    
    /// This method gets called whenever the pikko color was updated.
    func writeBackColor(color: UIColor) {
        print("New color: \(color)")
    }
}
