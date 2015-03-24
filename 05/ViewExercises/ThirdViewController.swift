//
//  ThirdViewController.swift
//  ViewExercises
//
//  Created by Rudd Taylor on 9/9/14.
//  Copyright (c) 2014 Rudd Taylor. All rights reserved.
//

import UIKit

class ThirdViewController: ExerciseViewController {

    var topLBox : UIView!
    var topRBox : UIView!
    var bottomLBox : UIView!
    var bottomRBox : UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseDescription.text = "View 3"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
        /* TODO:
        Build four blue squares, 20 points wide, one in each corner of the screen.
        They must stay in their respective corners on device rotation. 
        
        Use Autolayout.
        
        Your view should be in self.exerciseView, not self.view
        */
        
        //Initialize the empty UIViews and set background to blue
        topLBox = UIView()
        topLBox.backgroundColor = UIColor.blueColor()
        topLBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        topRBox = UIView()
        topRBox.backgroundColor = UIColor.blueColor()
        topRBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        bottomLBox = UIView()
        bottomLBox.backgroundColor = UIColor.blueColor()
        bottomLBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        bottomRBox = UIView()
        bottomRBox.backgroundColor = UIColor.blueColor()
        bottomRBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Add views to the main view
        exerciseView.addSubview(topLBox)
        exerciseView.addSubview(topRBox)
        exerciseView.addSubview(bottomLBox)
        exerciseView.addSubview(bottomRBox)
        
        //Define screen height
        let barHeight: CGFloat = 44.0
        let screenHeight = exerciseView.frame.height
        let navHeight = self.navigationController?.navigationBar.frame.height
        
        //Constraints for top left box
        let topLBoxTop = NSLayoutConstraint(item: topLBox,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: exerciseView,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: navHeight! + 20)
        
        let topLBoxLeading = NSLayoutConstraint(item: topLBox,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: exerciseView,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 0)
        
        let topLBoxHeight = NSLayoutConstraint(item: topLBox,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 20)
        
        let topLBoxWidth = NSLayoutConstraint(item: topLBox,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 20)
        
        //Constraints for top right box
        let topRBoxTop = NSLayoutConstraint(item: topRBox,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: exerciseView,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: navHeight! + 20)
        
        let topRBoxLeading = NSLayoutConstraint(item: topRBox,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: exerciseView,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 0)
        
        let topRBoxHeight = NSLayoutConstraint(item: topRBox,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 20)
        
        let topRBoxWidth = NSLayoutConstraint(item: topRBox,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 20)
        
        //Constraints for bottom left box
        let bottomLBoxTop = NSLayoutConstraint(item: bottomLBox,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: exerciseView,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: -barHeight)
        
        let bottomLBoxLeading = NSLayoutConstraint(item: bottomLBox,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: exerciseView,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 0)
        
        let bottomLBoxHeight = NSLayoutConstraint(item: bottomLBox,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 20)
        
        let bottomLBoxWidth = NSLayoutConstraint(item: bottomLBox,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 20)
        
        //Constraints for bottom right box
        let bottomRBoxTop = NSLayoutConstraint(item: bottomRBox,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: exerciseView,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: -barHeight)
        
        let bottomRBoxLeading = NSLayoutConstraint(item: bottomRBox,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: exerciseView,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 0)
        
        let bottomRBoxHeight = NSLayoutConstraint(item: bottomRBox,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 20)
        
        let bottomRBoxWidth = NSLayoutConstraint(item: bottomRBox,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 20)
        
        exerciseView.addConstraints([topLBoxTop, topLBoxLeading, topLBoxHeight, topLBoxWidth, topRBoxTop, topRBoxLeading, topRBoxHeight, topRBoxWidth, bottomLBoxTop, bottomLBoxLeading, bottomLBoxHeight, bottomLBoxWidth, bottomRBoxTop, bottomRBoxLeading, bottomRBoxHeight, bottomRBoxWidth])
        
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    func next() {
        self.performSegueWithIdentifier("four", sender: nil)
    }

}
