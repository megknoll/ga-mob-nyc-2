//
//  ThirdViewController.swift
//  ViewExercises
//
//  Created by Rudd Taylor on 9/9/14.
//  Copyright (c) 2014 Rudd Taylor. All rights reserved.
//

import UIKit

class ThirdViewController: ExerciseViewController {

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
        
        var ul = UIView()
        var ur = UIView()
        var ll = UIView()
        var lr = UIView()
        
        for view in [ul, ur, ll, lr] {
            view.backgroundColor = UIColor.blueColor()
            view.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.exerciseView.addSubview(view)
            
            let size: CGFloat = 20
            self.exerciseView.addConstraint(NSLayoutConstraint(
                item: view,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1.0,
                constant: size))
            self.exerciseView.addConstraint(NSLayoutConstraint(item: view,
                attribute: .Height,
                relatedBy: .Equal,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1.0,
                constant: size))
        }
        
        self.exerciseView.addConstraint(NSLayoutConstraint(item: ll, attribute: .Bottom, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Bottom, multiplier: 1.0, constant: -44))
        self.exerciseView.addConstraint(NSLayoutConstraint(item: ll, attribute: .Left, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Left, multiplier: 1.0, constant: 0))
        
        self.exerciseView.addConstraint(NSLayoutConstraint(item: ul, attribute: .Left, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Left, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: ul, attribute: .Top, relatedBy: .Equal, toItem: self.topLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: 0))
        
        self.exerciseView.addConstraint(NSLayoutConstraint(item: ur, attribute: .Right, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Right, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: ur, attribute: .Top, relatedBy: .Equal, toItem: self.topLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: 0))
        
        self.exerciseView.addConstraint(NSLayoutConstraint(item: lr, attribute: .Right, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Right, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: lr, attribute: .Bottom, relatedBy: .Equal, toItem: self.exerciseView, attribute: .Bottom, multiplier: 1.0, constant: -44))
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    func next() {
        self.performSegueWithIdentifier("four", sender: nil)
    }

}
