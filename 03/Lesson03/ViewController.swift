//
//  ViewController.swift
//  Lesson03
//
//  Created by Rudd Taylor on 9/28/14.
//  Copyright (c) 2014 General Assembly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /*
    TODO one: Hook up a swipeable area on the home screen that must present a modal dialog when swiped. You must create the modal dialog and present it in CODE (not the storyboard).
    TODO two: Add an imageview to the modal dialog presented in TODO two.
    TODO three: Add and hook up a ‘dismiss’ button below the above mentioned image view that will dismiss the modal dialog. Do this in CODE.
    TODO four: Hook up the button on the home screen to push ArrayTableViewController into view (via the navigation controller) when tapped. Do this by triggering a segue from this view controller. The method you are looking for is performSegueWithIdentifier. Find the identifier from the storyboard.
    */

    
    @IBOutlet weak var todoLabel: UILabel!
    
    //On button press peform segue of id "show"
    @IBAction func displayTableView(sender: AnyObject) {
        self.performSegueWithIdentifier("show", sender:self)
    }
    
    // Swipe event handler
    func onSwipe(sender:UISwipeGestureRecognizer) {
        
        //Instantiate a VC of class ModalView, and present w/ animation
        var mv = self.storyboard?.instantiateViewControllerWithIdentifier("modalIdVC") as ModalView
        self.presentViewController(mv, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create gesture recognizers & assign onSwipe function to handle the event
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("onSwipe:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("onSwipe:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        //Add gesture recognizers to label
        todoLabel.addGestureRecognizer(leftSwipe)
        todoLabel.addGestureRecognizer(rightSwipe)
        
    }

}

