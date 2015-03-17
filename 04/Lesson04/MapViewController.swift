//
//  MapViewController.swift
//  Lesson04
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var myMapTable: UITableView!
    
    @IBOutlet weak var leadingConstraintTextField: NSLayoutConstraint!
    
    var myTodoMap = Dictionary<String, String>()
    
    // Add key value pair to map, reset textfield & reload table
    func addMapItem() {
        let newKey = keyTextField.text
        let newValue = valueTextField.text
        
        // If both text fields have valid strings, add to map and reset
        if newKey != nil && newKey != "" && newValue != nil && newValue != "" {
            
            myTodoMap[newKey] = newValue

            // Animate and reload map
            UIView.animateWithDuration(0.3, animations: {
                self.leadingConstraintTextField.constant += 300
                self.keyTextField.alpha = 0
                self.valueTextField.alpha = 0
                self.view.layoutIfNeeded()
                }, completion : {(finished) in
                    UIView.animateWithDuration(0, animations : {
                        self.leadingConstraintTextField.constant = 30
                        self.keyTextField.alpha = 1
                        self.valueTextField.alpha = 1
                        self.keyTextField.text = ""
                        self.valueTextField.text = ""
                        self.myMapTable.reloadData()
                        self.view.layoutIfNeeded()
                    })
            })

        }
    }
    
    // On return key, update the table view
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        addMapItem()
        valueTextField.resignFirstResponder()
        return true
        
    }
    
    //Keyboard Notification Event
    func keyboardNotification(notification : NSNotification) {
        
        // On hide set color to red
        if notification.name == UIKeyboardWillHideNotification {
            keyTextField.backgroundColor = UIColor(red:0.988, green:0.486, blue:0.459, alpha: 1)
            valueTextField.backgroundColor = UIColor(red:0.988, green:0.486, blue:0.459, alpha: 1)
            
        // On show set color to blue
        } else if notification.name == UIKeyboardWillShowNotification {
            keyTextField.backgroundColor = UIColor(red:0.365, green:0.878, blue:1.000, alpha: 1)
            valueTextField.backgroundColor = UIColor(red:0.365, green:0.878, blue:1.000, alpha: 1)
        }
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myTodoMap.count
    }
    
    // Assign table cell text to map key & value items
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("mapViewCell", forIndexPath: indexPath) as UITableViewCell
        let tempKey = myTodoMap.keys.array[indexPath.row]
        
        cell.textLabel!.text = tempKey
        cell.detailTextLabel!.text = myTodoMap[tempKey]
        
        return cell
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add keyboard show and hide notifications to notification center
        var notify = NSNotificationCenter.defaultCenter()
        notify.addObserver(self, selector: Selector("keyboardNotification:"), name: UIKeyboardWillShowNotification, object: nil)
         notify.addObserver(self, selector: Selector("keyboardNotification:"), name: UIKeyboardWillHideNotification, object: nil)
        
        /*
        TODO three: Add TWO text views and a table view to this view controller, either using code or storybaord. Accept keyboard input from the two text views. When the 'return' button is pressed on the SECOND text view, add the text view data to a dictionary. The KEY in the dictionary should be the string in the first text view, the VALUE should be the second.
        TODO four: Make this class a UITableViewDelegate and UITableViewDataSource that supply this table view with cells that correspond to the values in the dictionary. Each cell should print out a unique pair of key/value that the map contains. When a new key/value is inserted, the table view should display it.
        TODO five: Make the background of the text boxes in this controller BLUE when the keyboard comes up, and RED when it goes down. Start with UIKeyboardWillShowNotification and NSNotificationCenter.
        */
    }
}
