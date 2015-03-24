//
//  SecondViewController.swift
//  ViewExercises
//
//  Created by Rudd Taylor on 9/9/14.
//  Copyright (c) 2014 Rudd Taylor. All rights reserved.
//

import UIKit

class SecondViewController: ExerciseViewController {
    
    var topLBox : UIView!
    var topRBox : UIView!
    var bottomLBox : UIView!
    var bottomRBox : UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.exerciseDescription.text = "View 2"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "next")
        /* TODO:
        Build four blue squares, 20 points wide, one in each corner of the screen. 
        They must stay in their respective corners on device rotation. 
        
        Use Springs & Struts.
        
        Your view should be in self.exerciseView, not self.view
        */
        
        
        // Initialize empty UIViews and set background to blue
        topLBox = UIView()
        topLBox.backgroundColor = UIColor.blueColor()
        
        topRBox = UIView()
        topRBox.backgroundColor = UIColor.blueColor()
        
        bottomLBox = UIView()
        bottomLBox.backgroundColor = UIColor.blueColor()
        
        bottomRBox = UIView()
        bottomRBox.backgroundColor = UIColor.blueColor()
        
        // Position the UI views
        updateSquareViews()
        
        // Add views to the main view
        exerciseView.addSubview(topLBox)
        exerciseView.addSubview(topRBox)
        exerciseView.addSubview(bottomLBox)
        exerciseView.addSubview(bottomRBox)
    }
    
    func updateSquareViews(){
        
        // Get screen and toolbar heights
        let barHeight: CGFloat = 44.0
        let boxWidth : CGFloat = 20.0
        
        let navHeight = self.navigationController?.navigationBar.frame.height
        let screenWidth = exerciseView.frame.width
        let screenHeight = exerciseView.frame.height
        
        //Determine max and min y coordinates given the toolbar heights
        let maxY = screenHeight-barHeight
        let minY = screenHeight < screenWidth ? navHeight! :navHeight!+20
        
        // Update view positions based on screen size
        topLBox.frame = CGRect(x:0,y:minY,width:boxWidth,height:boxWidth)
        topRBox.frame = CGRect(x:screenWidth-boxWidth, y:minY, width:boxWidth, height:boxWidth)
        bottomLBox.frame = CGRect(x:0,y:maxY-boxWidth,width:boxWidth,height:boxWidth)
        bottomRBox.frame = CGRect(x:screenWidth-boxWidth, y:maxY-boxWidth, width:boxWidth, height:boxWidth)
    }
    
    override func shouldAutorotate() -> Bool {
        updateSquareViews()
        return true
    }
    
    func next() {
        self.performSegueWithIdentifier("three", sender: nil)
    }
}
