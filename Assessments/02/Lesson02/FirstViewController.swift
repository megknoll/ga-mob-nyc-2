//
//  FirstViewController.swift
//  Lesson02
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    /*
    TODO one: hook up a button in interface builder to a new function (to be written) in this class. Also hook up the label to this class. When the button is clicked, the function to be written must make a label say ‘hello world!’
    
    TODO two: Connect the ‘name’ and ‘age’ text boxes to this class. Hook up the button to a NEW function (in addition to the function previously defined). That function must look at the string entered in the text box and print out “Hello {name}, you are {age} years old!”
    TODO three: Hook up the button to a NEW function (in addition to the two above). Print “You can drink” below the above text if the user is above 21. If they are above 18, print “you can vote”. If they are above 16, print “You can drive”
    TODO four: Hook up the button to a NEW function (in additino to the three above). Print “you can drive” if the user is above 16 but below 18. It should print “You can drive and vote” if the user is above 18 but below 21. If the user is above 21, it should print “you can drive, vote and drink (but not at the same time!”.
    */
    
    var name:String = ""
    var age:Int = -1
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var outputLabel2: UILabel!
    @IBOutlet weak var outputLabel3: UILabel!
    @IBOutlet weak var outputLabel4: UILabel!
    
    // GET NAME AND AGE
    // Set age to -1 if not an Int
    func getNameAndAge() {
        if nameField.text.isEmpty {
            name = ""
        } else {
            name = nameField.text
        }
        
        if ageField.text.isEmpty || ageField.text.toInt() == nil {
            age = -1
        } else {
            age = ageField.text.toInt()!
        }
    }
    
    // RESET TEXT FIELDS
    func resetNameAndAge() {
        nameField.text = ""
        ageField.text = ""
        outputLabel.text = ""
    }

    @IBAction func resetTextButton(sender: AnyObject) {
        resetNameAndAge()
    }

    
    
    // START OF TODO ASSIGNMENTS
    @IBAction func generateTxtButton(sender: AnyObject) {
        outputLabel.text = "Hello World!"
    }
    
    @IBAction func generateGreeting(sender: AnyObject) {
        getNameAndAge()
        
        if(name != "" && age != -1){
        outputLabel2.text = " Hello \(name), you are \(String(age)) years old!"
        } else if name != "" {
           outputLabel2.text = "Hello \(name)"
        } else if age != -1{
            outputLabel2.text = " Hello, you are \(String(age)) years old!"
        } else {
            outputLabel2.text = "Hello!"
        }
    }

    @IBAction func checkAgeButtonOne(sender: AnyObject) {
        getNameAndAge()
        if(age <= 0 ){
            outputLabel3.text = "Please input a valid age"
        } else if age >= 21 {
            outputLabel3.text = "You can drink!"
        } else if age >= 18 {
            outputLabel3.text = "You can vote!"
        } else if age >= 16 {
            outputLabel3.text = "You can drive!"
        } else {
            outputLabel3.text = "You're too young to do anything."
        }
    }
    
    @IBAction func checkAgeButtonTwo(sender: AnyObject) {
        getNameAndAge()
        if(age <= 0){
            outputLabel4.text = "Please input a valid age"
        } else if age >= 16 && age < 18 {
            outputLabel4.text = "You can drive!"
        } else if age >= 18 && age < 21 {
            outputLabel4.text = "You can drive and vote!"
        } else if age >= 21 {
            outputLabel4.text = "You can drive, vote and drink (but not at the same time!)"
        } else {
            outputLabel4.text = "You're too young to do anything."
        }
    }


}
