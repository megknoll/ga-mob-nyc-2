
//
//  SixthViewController.swift
//  Lesson07
//
//  Created by Rudd Taylor on 9/30/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class SixthViewController: UIViewController {

    var todoSix = [String]()
    
    @IBOutlet weak var textView: UITextView!
    
    var pathToFile : NSURL? {
        get {
            let fileName = "todoFive.plist"
            let docDirectory = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last as! NSURL
            
            let url = docDirectory.URLByAppendingPathComponent(fileName)
            return url
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = pathToFile {
            if let items = NSArray(contentsOfURL: path) as? [String]{
                self.todoSix = items
                
                var answer = ""
                for item in items {
                    answer += "\(item) "
                }
                
                textView.text = "\(textView.text). \n\nANSWER: \n\n\(answer)"
                
            }
        }
    }
}
