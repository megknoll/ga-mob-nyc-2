//
//  ViewController.swift
//  Lesson04
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class ArrayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var tableArrayView: UITableView!
    
    @IBOutlet weak var topConstraintTextField: NSLayoutConstraint!
    
    var myTodoArray:[String] = []
    
    // Add item to end of array, reset textfield & reload table
    func addArrayItem() {
        let newArrayItem = textInput.text
        
        if newArrayItem != nil || newArrayItem != "" {

            myTodoArray.append(newArrayItem)
            
            // Animate and reload table
            UIView.animateWithDuration(0.3, animations: {
                self.topConstraintTextField.constant += 300
                self.textInput.alpha = 0
                self.view.layoutIfNeeded()
                }, completion : {(finished) in
                    UIView.animateWithDuration(0.3, animations : {
                        self.topConstraintTextField.constant = 30
                        self.textInput.alpha = 1
                        self.textInput.text = ""
                        self.tableArrayView.reloadData()
                        self.view.layoutIfNeeded()
                    })
            })
        }
    }
    
    // On return key, update the table view
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        addArrayItem()
        textInput.resignFirstResponder()
        return true
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myTodoArray.count
    }
    
    // Assign table cell text to array items
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("arrayCell", forIndexPath: indexPath) as UITableViewCell

        cell.textLabel!.text = myTodoArray[indexPath.row]
        
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

