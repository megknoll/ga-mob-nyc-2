//
//  ViewController.swift
//  Calculator
//
//  Created by Meghan Knoll on 3/26/15.
//  Copyright (c) 2015 Meghan Knoll. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Main calculator views
    var mainPanel : UIView!
    var secondaryPanel : UIView!
    var outputLabel : UILabel!

    // Width contraints on the button panels
    var mainPanelWConstraint : NSLayoutConstraint!
    var secondPanelWConstraint : NSLayoutConstraint!
    
    // Adjusted font widths based on length of number entered
    var normalFont = UIFont(name: "HelveticaNeue-Thin", size: 100)
    var minFont = UIFont(name: "HelveticaNeue-Thin", size: 50)
    
    // Calculator operation variables
    let calculator = Calc()
    
    // Clear calculator stack
    func clear(sender: AnyObject){
        calculator.clear()
        outputLabel.font = normalFont
        outputLabel.text = "0"
    }
    
    // Handles mathematical operators
    func operation(sender: AnyObject){
        var title = sender.titleForState(UIControlState.Normal)
        var result = calculator.appendOperation(title!)
        
        println("action: \(title!), calc response: \(result)")
        
        if result != nil {
            let nf = NSNumberFormatter()
            nf.numberStyle = .DecimalStyle
            nf.maximumFractionDigits = 5
            let stringResult = nf.stringFromNumber(result!)
            outputLabel.font = count(stringResult!) > 6 ? minFont : normalFont
            outputLabel.text = stringResult
        } else {
            outputLabel.text = "ERROR"
        }
        
        UIView.animateWithDuration(0.1, animations: {
            (sender as! UIButton).alpha = 0.8
            }, completion : {(finished) in
                UIView.animateWithDuration(0.1, animations : {
                    (sender as! UIButton).alpha = 1.0
                })
        })
    }
    
    // Handles number entry
    func number(sender: AnyObject){
        var currentButton = sender as! UIButton
        var title = sender.titleForState(UIControlState.Normal)
        var result = calculator.appendNumber(title!)
        
        outputLabel.font = count(result) > 6 ? minFont : normalFont
        
        println("number: \(title!), calc response: \(result)")
        
        UIView.animateWithDuration(0.1, animations: {
            (sender as! UIButton).alpha = 0.8
            }, completion : {(finished) in
                UIView.animateWithDuration(0.1, animations : {
                    (sender as! UIButton).alpha = 1.0
                })
        })
        
        outputLabel.text = result
        
        
    }
    
    // Handles toggle between Radians and Degrees
    func radToggle(sender: AnyObject){
        var currentButton = sender as! UIButton
        var title = sender.titleForState(UIControlState.Normal)
        
        if title == "Rad"{
            calculator.radMode = true
            currentButton.setTitle("Deg", forState: .Normal)
        } else {
            calculator.radMode = false
            currentButton.setTitle("Rad", forState: .Normal)
        }
    }
    
    // Placeholder function for unassigned buttons
    func placeholder(sender: AnyObject){
        var currentButton = sender as! UIButton
        var title = sender.titleForState(UIControlState.Normal)
        
        UIView.animateWithDuration(0.1, animations: {
            (sender as! UIButton).alpha = 0.8
            }, completion : {(finished) in
                UIView.animateWithDuration(0.1, animations : {
                    (sender as! UIButton).alpha = 1.0
                })
        })
    }
    
    // Create and style buttons with provided target and colors
    func createButton(text: String, target: Selector, buttonColor: UIColor, textColor: UIColor)  -> UIButton{
        
        let tempButton = UIButton()
        tempButton.backgroundColor = buttonColor
        tempButton.layer.borderColor = UIColor(red:0.000, green:0.000, blue:0.000, alpha: 1).CGColor
        tempButton.layer.borderWidth = 0.25
        tempButton.setTitle(text, forState: .Normal)
        tempButton.setTitleColor(textColor, forState: .Normal)
        tempButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
        tempButton.titleLabel?.adjustsFontSizeToFitWidth = true
        tempButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        tempButton.addTarget(self, action: target, forControlEvents: UIControlEvents.TouchUpInside)
        
        return tempButton
        
    }
    
    // Given a parent view and a matrix of buttons, lay the buttons out in a flex width grid
    func layoutButtons(buttonArray: [[UIButton]], parentView: UIView){
        
        let yMultiplier = 1.0/CGFloat(buttonArray.count)
        let xMultiplier = 1.0/CGFloat(buttonArray[0].count)
        
        for rIndex in 0...buttonArray.count - 1 {
            for cIndex in 0...buttonArray[rIndex].count - 1{
                
                var currentButton = buttonArray[rIndex][cIndex]
                currentButton.setTranslatesAutoresizingMaskIntoConstraints(false)
                parentView.addSubview(currentButton)
                
                var leadingX : NSLayoutConstraint!
                var leadingY : NSLayoutConstraint!
                
                if cIndex == 0{
                    leadingX = NSLayoutConstraint(item: currentButton,
                        attribute: NSLayoutAttribute.Leading,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: parentView,
                        attribute: NSLayoutAttribute.Leading,
                        multiplier: 1.0,
                        constant: 0)
                } else {
                    leadingX = NSLayoutConstraint(item: currentButton,
                        attribute: NSLayoutAttribute.Leading,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: buttonArray[rIndex][cIndex-1],
                        attribute: NSLayoutAttribute.Trailing,
                        multiplier: 1.0,
                        constant: 0)
                }
                if rIndex == 0{
                    leadingY = NSLayoutConstraint(item: currentButton,
                        attribute: NSLayoutAttribute.Top,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: parentView,
                        attribute: NSLayoutAttribute.Top,
                        multiplier: 1.0,
                        constant: 0)
                } else {
                    leadingY = NSLayoutConstraint(item: currentButton,
                        attribute: NSLayoutAttribute.Top,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: buttonArray[rIndex-1][cIndex],
                        attribute: NSLayoutAttribute.Bottom,
                        multiplier: 1.0,
                        constant: 0)
                }
                
                let modifiedMultiplier = buttonArray[rIndex][cIndex].titleForState(UIControlState.Normal)! == "0" ?(xMultiplier * 2.0) : xMultiplier
                let wConstraint = NSLayoutConstraint(item: currentButton,
                    attribute: NSLayoutAttribute.Width,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: parentView,
                    attribute: NSLayoutAttribute.Width,
                    multiplier: modifiedMultiplier,
                    constant: 0)
                
                let hConstraint = NSLayoutConstraint(item: currentButton,
                    attribute: NSLayoutAttribute.Height,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: parentView,
                    attribute: NSLayoutAttribute.Height,
                    multiplier: yMultiplier,
                    constant: 0)
                    
                    parentView.addConstraints([leadingX,leadingY, wConstraint, hConstraint])
            }
        }
    }
    
    // On rotation hide/show scientific panel, adjust fonts
    override func shouldAutorotate() -> Bool {
        
        let panelWidth = view.frame.width * 0.6
        let orientation = UIDevice.currentDevice().orientation
        
        if orientation == .Portrait || orientation == .Unknown{
            mainPanelWConstraint.constant = 0.0
            secondPanelWConstraint.constant = 0.0
            
            normalFont = UIFont(name: "HelveticaNeue-Thin", size: 100)
            outputLabel.font = count(outputLabel.text!) > 6 ? minFont : normalFont
            
            for view in mainPanel.subviews {
                if view is UIButton {
                    var tempButton = view as! UIButton
                    tempButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 30)
                }
            }
            
            view.layoutIfNeeded()
            mainPanel.layoutIfNeeded()
        } else {
            mainPanelWConstraint.constant = -panelWidth
            secondPanelWConstraint.constant = panelWidth
            
            normalFont = UIFont(name: "HelveticaNeue-Thin", size: 50)
            outputLabel.font = normalFont
            
            for view in mainPanel.subviews {
                if view is UIButton {
                    var tempButton = view as! UIButton
                    tempButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
                }
            }
            
            view.layoutIfNeeded()
            mainPanel.layoutIfNeeded()
        }
        
        return true
    }
    
    // Set up initial views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blackColor()
        
        mainPanel = UIView()
        mainPanel.backgroundColor = UIColor(red:0.816, green:0.820, blue:0.827, alpha: 1)
        mainPanel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(mainPanel)
        
        secondaryPanel = UIView()
        secondaryPanel.backgroundColor = UIColor(red:0.573, green:0.000, blue:0.251, alpha: 1)
        secondaryPanel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(secondaryPanel)
        
        outputLabel = UILabel()
        outputLabel.backgroundColor = UIColor(red:0.000, green:0.000, blue:0.000, alpha: 1)
        outputLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 100)
        outputLabel.textAlignment = NSTextAlignment.Right
        outputLabel.textColor = UIColor.whiteColor()
        outputLabel.text = "0"
        outputLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(outputLabel)
        
        //OUTPUT LABEL CONSTRAINTS
        let outputWConstraint = NSLayoutConstraint(item: outputLabel,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: -20)
        
        let outputHConstraint = NSLayoutConstraint(item: outputLabel,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Height,
            multiplier: 0.25,
            constant: 0)
        
        let outputLeading = NSLayoutConstraint(item: outputLabel,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.TrailingMargin,
            multiplier: 1.0,
            constant: 0)
        
        let outputTop = NSLayoutConstraint(item: outputLabel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.TopMargin,
            multiplier: 1.0,
            constant: 0)
        
        //MAIN CALCULATOR PANEL CONTRAINTS
        mainPanelWConstraint = NSLayoutConstraint(item: mainPanel,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: 0)
        
        let mainPanelHConstraint = NSLayoutConstraint(item: mainPanel,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Height,
            multiplier: 0.75,
            constant: 0)
        
        let mainPanelLeading = NSLayoutConstraint(item: mainPanel,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 0)
        
        let mainPanelTop = NSLayoutConstraint(item: mainPanel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: outputLabel,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 0)
        
        //SECONDARY CALCULATOR PANEL CONTRAINTS
        secondPanelWConstraint = NSLayoutConstraint(item: secondaryPanel,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 0)
        
        let secondPanelHConstraint = NSLayoutConstraint(item: secondaryPanel,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Height,
            multiplier: 0.75,
            constant: 0)
        
        let secondPanelLeading = NSLayoutConstraint(item: secondaryPanel,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 0)
        
        let secondPanelTop = NSLayoutConstraint(item: secondaryPanel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: outputLabel,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 0)
        
        view.addConstraints([outputHConstraint, outputWConstraint, outputLeading, outputTop, mainPanelHConstraint, mainPanelWConstraint, mainPanelLeading, mainPanelTop, secondPanelWConstraint, secondPanelHConstraint, secondPanelLeading, secondPanelTop])
        
        var actionColor = UIColor(red:0.573, green:0.000, blue:0.251, alpha: 1)
        var actionTextColor = UIColor.whiteColor()
        
        var disabledColor = UIColor(red:0.549, green:0.545, blue:0.525, alpha: 1)
        
        var numColor = UIColor(red:0.988, green:0.706, blue:0.678, alpha: 1)
        var numTextColor = UIColor.blackColor()
        
        var secondaryColor = UIColor(red:0.988, green:0.486, blue:0.459, alpha: 1)
        var secondaryTextColor = UIColor.whiteColor()
        
        // Grid of basic calculator buttons
        let buttonGrid = [[createButton("AC", target: "clear:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("+/-", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("%", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("÷", target: "operation:", buttonColor: actionColor, textColor: actionTextColor)],
            [createButton("7", target: "number:", buttonColor: numColor, textColor: numTextColor),
            createButton("8", target: "number:", buttonColor: numColor, textColor: numTextColor),
            createButton("9", target: "number:", buttonColor: numColor, textColor: numTextColor),
            createButton("x", target: "operation:", buttonColor: actionColor, textColor: actionTextColor)],
            [createButton("4", target: "number:", buttonColor: numColor, textColor: numTextColor),
            createButton("5", target: "number:", buttonColor: numColor, textColor: numTextColor),
            createButton("6", target: "number:", buttonColor: numColor, textColor: numTextColor),
            createButton("-", target: "operation:", buttonColor: actionColor, textColor: actionTextColor)],
            [createButton("1", target: "number:", buttonColor: numColor, textColor: numTextColor),
            createButton("2", target: "number:", buttonColor: numColor, textColor: numTextColor),
            createButton("3", target: "number:", buttonColor: numColor, textColor: numTextColor),
            createButton("+", target: "operation:", buttonColor: actionColor, textColor: actionTextColor)],
            [createButton("0", target: "number:", buttonColor: numColor, textColor: numTextColor),
            createButton(".", target: "number:", buttonColor: numColor, textColor: numTextColor),
            createButton("=", target: "operation:", buttonColor: actionColor, textColor: actionTextColor)]]
        
        layoutButtons(buttonGrid, parentView: mainPanel)
        
        // Grid of buttons for scientific panel
        let secondaryButtonGrid = [[createButton("(", target: "placeholder:", buttonColor: disabledColor, textColor: secondaryTextColor),
            createButton(")", target: "placeholder:", buttonColor: disabledColor, textColor: secondaryTextColor),
            createButton("mc", target: "placeholder:", buttonColor: disabledColor, textColor: secondaryTextColor),
            createButton("m+", target: "placeholder:", buttonColor: disabledColor, textColor: secondaryTextColor),
            createButton("m-", target: "placeholder:", buttonColor: disabledColor, textColor: secondaryTextColor),
            createButton("mr", target: "placeholder:", buttonColor: disabledColor, textColor: secondaryTextColor)],
            [createButton("2nd", target: "placeholder:", buttonColor: disabledColor, textColor: secondaryTextColor),
            createButton("x^2", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("x^3", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("x^y", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("e^x", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("10^x", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor)],
            [createButton("1/x", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("2√x", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("3√x", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("y√x", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("ln", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("log10", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor)],
            [createButton("x!", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("sin", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("cos", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("tan", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("e", target: "number:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("EE", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor)],
            [createButton("Rad", target: "radToggle:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("sinh", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("cosh", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("tanh", target: "operation:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("π", target: "number:", buttonColor: secondaryColor, textColor: secondaryTextColor),
            createButton("Rand", target: "number:", buttonColor: secondaryColor, textColor: secondaryTextColor)]]
        
        layoutButtons(secondaryButtonGrid, parentView: secondaryPanel)
        
    }

}

