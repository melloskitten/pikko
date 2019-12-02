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
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1.0)
        
        // This is how you can set up Pikko without any constraints.
        // (Simplest)
        setUpPikko()
        
        // This is how you can set up Pikko with programmatically created
        // Autolayout constraints.
        setUpPikkoWithAutolayoutConstraints()
    }
    
    /// If you add Pikko via interface builder and you want to set
    /// a color on your picker, make sure to call it from this method, NOT the viewDidLoad.
    override func viewDidAppear(_ animated: Bool) {
        // For example:
        // PikkoView.setColor(.purple)
    }
    
    /// Simplest way to set up Pikko, without autoconstraints.
    private func setUpPikko() {
        // Initialize a new Pikko instance.
        let pikko = Pikko(dimension: 300, setToColor: .purple)
        
        // Set the PikkoDelegate to get notified on new color changes.
        pikko.delegate = self
        
        // Set Pikko center and add it to the main view.
        pikko.center.x = self.view.center.x
        pikko.center.y = self.view.center.y + 200
        self.view.addSubview(pikko)
        
        // Get the current color.
        _ = pikko.getColor()
    }
    
    // How to set up Pikko with programmatic constraints.
    private func setUpPikkoWithAutolayoutConstraints() {
        // Initialize a new Pikko instance.
        let pikko = Pikko(dimension: 300, setToColor: .purple)
        
        // Set the PikkoDelegate to get notified on new color changes.
        pikko.delegate = self
        
        // Set Pikko center and add it to the main view.
        self.view.addSubview(pikko)
        
        // Get the current color.
        _ = pikko.getColor()
        
        // Set autoconstraints.
        pikko.translatesAutoresizingMaskIntoConstraints = false
        pikko.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pikko.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -200).isActive = true

    }
}

// MARK: - PikkoDelegate methods.

extension ViewController: PikkoDelegate {
    
    /// This method gets called whenever the pikko color was updated.
    func writeBackColor(color: UIColor) {
        print("New color: \(color)")
    }
}
