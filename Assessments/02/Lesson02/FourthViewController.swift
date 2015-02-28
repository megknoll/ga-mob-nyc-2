//
//  FourthViewController.swift
//  Lesson02
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
/*
    TODO seven: Hook up the text input box, label and and a ‘calculate’ button. Create a ‘fibonacci adder’ class with a method ‘fibonacciNumberAtIndex' which takes indexOfFibonacciNumber (an integer).  When the button is pressed, create an instance of that class, call the method, and print out the appropriate fibonacci number of an inputted integer.
    The first fibonacci number is 0, the second is 1, the third is 1, the fourth is two, the fifth is 3, the sixth is 5, etc. The Xth fibonacci number is the sum of the X-1th fibonacci number and the X-2th fibonacci number.
*/
    
    
    @IBOutlet weak var numField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    var numInput:Int = 0
    var error:Bool = false
    
    // GET TEXT FIELD VALUE
    // Display error message if field does not contain a number
    // Set error to true if field does not contain a number
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
    
    // GENERATE FIBONACCI NUMBER
    func getFibonacci(base:Int) -> Int {
        if base == 1 {
            return 0
        } else if base == 2 {
            return 1
        } else {
            return getFibonacci(base - 1) + getFibonacci(base - 2)
        }
    }
    
    // TODO SEVEN
    @IBAction func calculateButton(sender: AnyObject) {
        getNumber()
        
        if error {
            answerLabel.text = ""
        } else if numInput <= 0 {
            errorLabel.text = "Number must be greater than 0"
        } else {
            var fib = getFibonacci(numInput)
            answerLabel.text = String(fib)
        }
    }
}
