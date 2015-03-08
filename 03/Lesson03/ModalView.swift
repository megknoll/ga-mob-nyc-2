//
//  ModalView.swift
//  Lesson03
//
//  Created by Meghan Knoll on 3/8/15.
//  Copyright (c) 2015 General Assembly. All rights reserved.
//

import UIKit

class ModalView: UIViewController {

    // Dismiss modal view on button press
    @IBAction func dismissButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
