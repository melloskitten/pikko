//
//  ViewController.swift
//  Pikko
//
//  Created by Sandra on 09/18/2018.
//  Copyright (c) 2018 Sandra. All rights reserved.
//

import UIKit
import Pikko

class ViewController: UIViewController {

    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 0.1176, green: 0.1176, blue: 0.1176, alpha: 1.0) 
        
        var pikko = PikkoView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        pikko.center = self.view.center
        self.view.addSubview(pikko)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

