//
//  FourthViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var pathToFile : NSURL? {
        get {
            let fileName = "todo.plist"
            let docDirectory = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last as! NSURL
            
            let url = docDirectory.URLByAppendingPathComponent(fileName)
            return url
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let path = pathToFile {
            println("found file again")
            if let item = NSString(contentsOfURL: path, encoding: NSUnicodeStringEncoding, error: nil) {
                println("read item from file")
                textView.text = "\(textView.text).\n\nANSWER:\n\n\(item)"
            }
        }
    }
}
