//
//  SecondViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var baseText = ""
    
    func updateText() {
        var testString = NSUserDefaults.standardUserDefaults().stringForKey("settings_name")
        var testSlider = NSUserDefaults.standardUserDefaults().stringForKey("settings_slider")
        
        testString = testString == nil ? "empty" : testString
        testSlider = testSlider == nil ? "empty" : testSlider
        
        textView.text = "\(baseText). \n \nANSWER: \n \ntest_string: \(testString!) \ntest_number: \(testSlider!)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseText = textView.text
        updateText()
        
        // Add an observer for settings update event
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateText",name:NSUserDefaultsDidChangeNotification, object: nil)
        
        
    }
}
