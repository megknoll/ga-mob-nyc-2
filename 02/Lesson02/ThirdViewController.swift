//
//  ThirdViewController.swift
//  Lesson02
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
/*
    TODO six: Hook up the number input text field, button and text label to this class. When the button is pressed, a message should be printed to the label indicating whether the number is even.

*/
    @IBOutlet weak var numField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    var numInput:Int = 0
    var error:Bool = false
    
    // GET TEXT FIELD VALUE
    // Display error message if field does not contain a number
    // Set error bool to true if field does not contain a number
    func getNumber(){
        if numField.text.isEmpty || numField.text.toInt() == nil {
            errorLabel.text = "Please enter a valid integer"
            error = true
        } else {
            numInput = numField.text.toInt()!
            errorLabel.text = ""
            error = false
        }
    }

    //TODO SIX
    @IBAction func calculateButton(sender: AnyObject) {
        getNumber()
        
        if error {
            answerLabel.text = ""
        } else if numInput % 2 == 0 {
            answerLabel.text = "Is Even"
        } else {
            answerLabel.text = "Is Not Even"
        }
        
        
    }
}
