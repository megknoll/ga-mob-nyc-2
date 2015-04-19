//
//  FifthViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class FifthViewController: UIViewController {

    var todoFive = [String]()
    
    @IBOutlet weak var textView: UITextView!
    
    var pathToFile : NSURL? {
        get {
            let fileName = "todoFive.plist"
            let docDirectory = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last as! NSURL
            
            let url = docDirectory.URLByAppendingPathComponent(fileName)
            return url
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        todoFive = split(textView.text) {$0 == " "}
        
        if segue.identifier == "saveSegueTwo" {
            println("starting save")
            if self.pathToFile != nil {
                (self.todoFive as NSArray).writeToURL(self.pathToFile!, atomically: true)
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
