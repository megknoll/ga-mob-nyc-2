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
