//
//  FirstViewController.swift
//  ViewExercises
//
//  Created by Rudd Taylor on 9/9/14.
//  Copyright (c) 2014 Rudd Taylor. All rights reserved.
//

import UIKit

class FirstViewController: ExerciseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseDescription.text = "View 1"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
        /* TODO:
        Create a red box (10px tall, the width of the screen) with a black border on the very top of the screen below the nav bar,
        and a black box with a red border on the very bottom of the screen (same dimensions), above the toolbar.
        
        Use Springs & Struts.
        
        Your view should be in self.exerciseView, not self.view
        */
        
        // Get screen and toolbar heights
        let navHeight = self.navigationController?.navigationBar.frame.height
        let barHeight: CGFloat = 44.0
        
        let screenWidth = exerciseView.frame.width
        let screenHeight = exerciseView.frame.height
        
        let maxY = screenHeight-barHeight
        let minY = navHeight!+20
        
        // Create top UIView
        var topBox = UIView(frame: CGRect(x:0,y:minY,width:screenWidth,height:10))
        topBox.layer.borderColor = UIColor.blackColor().CGColor
        topBox.layer.borderWidth = 2
        topBox.backgroundColor = UIColor.redColor()
        
        // Create bottom UIView
        var bottomBox = UIView(frame: CGRect(x:0, y:maxY-10, width:screenWidth,height:10))
        bottomBox.layer.borderColor = UIColor.redColor().CGColor
        bottomBox.layer.borderWidth = 2
        bottomBox.backgroundColor = UIColor.blackColor()
        
        // Add views to the main view
        exerciseView.addSubview(topBox)
        exerciseView.addSubview(bottomBox)
        
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    
    func next() {
        self.performSegueWithIdentifier("two", sender: nil)
    }
}
