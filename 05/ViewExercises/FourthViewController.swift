//
//  FourthViewController.swift
//  ViewExercises
//
//  Created by Rudd Taylor on 9/9/14.
//  Copyright (c) 2014 Rudd Taylor. All rights reserved.
//

import UIKit

class FourthViewController: ExerciseViewController, UIScrollViewDelegate {

    var purpleLabel : UILabel!
    var blueBox : UIView!
    var redBox : UIView!
    var scroller : UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseDescription.text = "View 4"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
        /* TODO:
        Build a scroll view that takes up the entire screen. 
        
        In the scroll view, place a blue box at the top (20px high, 10px horizontal margins with the screen, a very tall (1000+px, width the same as the screen) purple label containing white text in the middle, and a red box at the bottom (20px high, 10px horizontal margins with the screen). The scroll view should scroll the entire height of the content.
        
        Use Autolayout.

        
        Your view should be in self.exerciseView, not self.view.
        */
        
        // Initialize scroll view
        scroller = UIScrollView()
        scroller.contentSize = CGSize(width:exerciseView.frame.width, height: 1040)
        scroller.delegate = self
        scroller.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Initialize red UIView
        redBox = UIView()
        redBox.backgroundColor = UIColor.redColor()
        redBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Initialize blue UIView
        blueBox = UIView()
        blueBox.backgroundColor = UIColor.blueColor()
        blueBox.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Initialize purple UILabel
        purpleLabel = UILabel()
        purpleLabel.backgroundColor = UIColor.purpleColor()
        purpleLabel.textColor = UIColor.whiteColor()
        purpleLabel.text = "Hello Scrolling World"
        purpleLabel.textAlignment = .Center
        purpleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Add subviews to scroll view
        scroller.addSubview(blueBox)
        scroller.addSubview(redBox)
        scroller.addSubview(purpleLabel)
        
        // Add scrollview to main view
        exerciseView.addSubview(scroller)
        
        
        // Define screen height
        let barHeight: CGFloat = 44.0
        let screenHeight = exerciseView.frame.height
        let screenWidth = exerciseView.frame.width
        let navHeight = self.navigationController?.navigationBar.frame.height
        
        // Constraints for scroll view
        let scrollTop = NSLayoutConstraint(item: scroller,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: exerciseView,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: navHeight! + 20)
        
        let scrollLeading = NSLayoutConstraint(item: scroller,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: exerciseView,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 0)
        
        let scrollTrailing = NSLayoutConstraint(item: scroller,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: exerciseView,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 0)
        
        let scrollBottom = NSLayoutConstraint(item: scroller,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: exerciseView,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: -barHeight)
        
        exerciseView.addConstraints([scrollTop, scrollLeading, scrollTrailing, scrollBottom])
        
        // Constraints for Blue Box within ScrollView
       let blueTop = NSLayoutConstraint(item: blueBox,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: scroller,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 0)
        
        let blueHeight = NSLayoutConstraint(item: blueBox,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 20)
        
        // establish width for scroll view
        let blueWidth = NSLayoutConstraint(item: blueBox,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: screenWidth-20)
        
        let blueLeading = NSLayoutConstraint(item: blueBox,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: scroller,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 10)
        
        let blueTrailing = NSLayoutConstraint(item: blueBox,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: scroller,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: -10)
        
        // Constraints for purple layout within scroll view
        let purpleTop = NSLayoutConstraint(item: purpleLabel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: blueBox,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 0)
        
        let purpleHeight = NSLayoutConstraint(item: purpleLabel,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 1000)
        
        let purpleLeading = NSLayoutConstraint(item: purpleLabel,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: scroller,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 0)
        
        let purpleTrailing = NSLayoutConstraint(item: purpleLabel,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: scroller,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 0)

        // Constraints for red box in Scroll View
        let redTop = NSLayoutConstraint(item: redBox,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: purpleLabel,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 0)
        
        let redBottom = NSLayoutConstraint(item: redBox,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: scroller,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 0)
        
        let redHeight = NSLayoutConstraint(item: redBox,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 20)
        
        let redLeading = NSLayoutConstraint(item: redBox,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: scroller,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 10)
        
        let redTrailing = NSLayoutConstraint(item: redBox,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: scroller,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: -10)
        
        scroller.addConstraints([blueTop, blueHeight, blueWidth, blueLeading, blueTrailing, redTrailing, redLeading, redHeight, redTop, redBottom, purpleTrailing, purpleLeading, purpleHeight, purpleTop])
        
    }
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
    
    func next() {
        self.performSegueWithIdentifier("five", sender: nil)
    }

}
