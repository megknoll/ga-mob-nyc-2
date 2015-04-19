//
//  FirstViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let testString = NSUserDefaults.standardUserDefaults().stringForKey("test_string")
        let testNum = NSUserDefaults.standardUserDefaults().stringForKey("test_number")
        
        textView.text = "\(textView.text). \n \nANSWER: \n \ntest_string: \(testString!) \ntest_number: \(testNum!)"
    }
}