//
//  FifthViewController.swift
//  ViewExercises
//
//  Created by Rudd Taylor on 9/9/14.
//  Copyright (c) 2014 Rudd Taylor. All rights reserved.
//

import UIKit

class FifthViewController: ExerciseViewController {
    
    var exampleButton : UIButton!
    var buttonCenterY : NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseDescription.text = "View 5"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
        /* TODO:
        Create a green button with a red border that says ‘Tap me!’ (50px by 50px), center it in the middle of the screen.
        Once tapped, the button should animate up 20 pixels and turn red, then immediately back down 20 pixels and turn back to green. It should not be clickable while animating.
        
        Use Autolayout.
        
        Your view should be in self.exerciseView, not self.view
        */
        
        // Create UIButton & Set Target
        exampleButton = UIButton()
        exampleButton.backgroundColor = UIColor.greenColor()
        exampleButton.layer.borderColor = UIColor.redColor().CGColor
        exampleButton.layer.borderWidth = 2
        exampleButton.setTitle("Tap Me!", forState: .Normal)
        exampleButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        exampleButton.titleLabel?.adjustsFontSizeToFitWidth = true
        exampleButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        exampleButton.addTarget(self, action: "onTap:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Add button to parent view
        exerciseView.addSubview(exampleButton)
        
        // Create constraints for button position
        let buttonCenterX = NSLayoutConstraint(item: exampleButton,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: exerciseView,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0)
        
        buttonCenterY = NSLayoutConstraint(item: exampleButton,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: exerciseView,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 1.0,
            constant: 0)
        
        let buttonWidth = NSLayoutConstraint(item: exampleButton,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 50)
        
        let buttonHeight = NSLayoutConstraint(item: exampleButton,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 50)
        
        // Add button constraints to parent view
        exerciseView.addConstraints([buttonCenterX,buttonCenterY,buttonWidth,buttonHeight])
    }
    
    
    func onTap(sender: AnyObject){
        
        // Disable button
        exampleButton.enabled = false
        
        // Show success animation
        UIView.animateWithDuration(0.3, animations: {
            self.buttonCenterY.constant -= 20
            self.exampleButton.backgroundColor = UIColor.redColor()
            self.view.layoutIfNeeded()
            }, completion : {(finished) in
                UIView.animateWithDuration(0.3, animations : {
                    self.buttonCenterY.constant = 0
                    self.exampleButton.backgroundColor = UIColor.greenColor()
                    self.view.layoutIfNeeded()
                })
                
            // Enable button when animation completes
            self.exampleButton.enabled = true
        })
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
    
    func next() {
        self.performSegueWithIdentifier("six", sender: nil)
    }

}
