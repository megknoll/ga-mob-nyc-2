//
//  SecondViewController.swift
//  Lesson02
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    //TODO five: Display the cumulative sum of all numbers added every time the ‘add’ button is pressed. Hook up the label, text box and button to make this work.
    
    @IBOutlet weak var numField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    var currentSum:Int = 0
    var numInput:Int = 0
    
    
    // GET LABEL AND TEXT FIELD VALUES
    // Display error message if text field does not contain a number
    func getNumberAndSum(){
        if numField.text.isEmpty || numField.text.toInt() == nil {
            numInput = 0
            errorLabel.text = "Please enter a valid integer"
        } else {
            numInput = numField.text.toInt()!
            errorLabel.text = ""
        }
        
        if sumLabel.text?.toInt() != nil {
            currentSum = (sumLabel.text?.toInt())!
        } else {
            currentSum = 0
        }
    }
    
    //START OF TODO FIVE
    @IBAction func addButton(sender: AnyObject) {
        getNumberAndSum()
    
        currentSum += numInput
        sumLabel.text = String(currentSum)
        
    }
    
    
    
    
}
