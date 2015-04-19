//
//  ThirdViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var pathToFile : NSURL? {
        get {
            let fileName = "todo.plist"
            let docDirectory = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last as! NSURL
            
            let url = docDirectory.URLByAppendingPathComponent(fileName)
            return url
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if segue.identifier == "saveSegue" {
            println("starting save")
            if self.pathToFile != nil {
                println("found file")
                let stringToSave = textView.text
                stringToSave.writeToURL(self.pathToFile!, atomically: true, encoding: NSUnicodeStringEncoding)
                println("wrote to file: \(stringToSave)")
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
