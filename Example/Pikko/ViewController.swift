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
        super.viewDidLoad()
        var test = PikkoColorPicker(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.view.addSubview(test)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

