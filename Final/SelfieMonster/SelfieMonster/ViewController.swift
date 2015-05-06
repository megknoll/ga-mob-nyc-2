//
//  ViewController.swift
//  SelfieMonster
//
//  Created by Meghan Knoll on 4/30/15.
//  Copyright (c) 2015 Meghan Knoll. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var monsterButton : UIButton!
    var grownupLabel : UILabel!
    var galleryButton : UIButton!
    var cameraButton : UIButton!
    var starscapeView : Starscape!
    
    func camPressed(sender: AnyObject){
        println("camera")
    }
    
    func monsterPressed(sender: AnyObject){
        println("monster")
    }
    
    func galleryPressed(sender: AnyObject){
        println("gallery")
    }
    
    func presentGrownUpModal(sender: AnyObject){
        println("this happened")
        var grownup = AgeGateView()
        grownup.modalPresentationStyle = .Custom
        self.presentViewController(grownup, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundTile : UIImage = UIImage(named:"background_fibers.jpg")!
        self.view.backgroundColor = UIColor(patternImage: backgroundTile)
        
        starscapeView = Starscape(frame: CGRect(x: 0, y: 0, width: (view.frame.width), height: (view.frame.height - 80)))
        view.addSubview(starscapeView)
        //initStarAnimation()
        
        galleryButton = UIButton()
        galleryButton.setImage(UIImage(named: "photo_icon_small.png"), forState:.Normal)
        galleryButton.backgroundColor = UIColor(red:0.278, green:0.718, blue:0.635, alpha: 0.5)
        galleryButton.addTarget(self, action: "galleryPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        galleryButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(galleryButton)
        
        // gallery constraints
        let galleryTrailing = NSLayoutConstraint(item: galleryButton,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 0)
        
        let galleryHeight = NSLayoutConstraint(item: galleryButton,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 80)
        
        let galleryWidth = NSLayoutConstraint(item: galleryButton,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Width,
            multiplier: 0.5,
            constant: 0)
        
        let galleryY = NSLayoutConstraint(item: galleryButton,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 0)

        cameraButton = UIButton()
        cameraButton.setImage(UIImage(named: "camera_icon_small_pressed.png"), forState:.Normal)
        cameraButton.addTarget(self, action: "camPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        cameraButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(cameraButton)
        
        // cam constraints
        let camLeading = NSLayoutConstraint(item: cameraButton,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 0)
        
        let camHeight = NSLayoutConstraint(item: cameraButton,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 80)
        
        let camWidth = NSLayoutConstraint(item: cameraButton,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Width,
            multiplier: 0.5,
            constant: 0)
        
        let camY = NSLayoutConstraint(item: cameraButton,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 0)

        monsterButton = UIButton()
        monsterButton.setImage(UIImage(named: "monster_button_2x.png"), forState:.Normal)
        monsterButton.setImage(UIImage(named: "monster_button_2x_pressed.png"), forState:.Highlighted)
        monsterButton.addTarget(self, action: "monsterPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        monsterButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(monsterButton)
        
        // monster button constraints
        let buttonWidth = NSLayoutConstraint(item: monsterButton,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 272)
        
        let buttonHeight = NSLayoutConstraint(item: monsterButton,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 280)
        
        let buttonX = NSLayoutConstraint(item: monsterButton,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0)
        
        let buttonY = NSLayoutConstraint(item: monsterButton,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 1.0,
            constant: -20)
        
        grownupLabel = UILabel()
        grownupLabel.font = UIFont(name: "ArialRoundedMTBold", size: 12.0)
        grownupLabel.text = "FOR GROWN-UPS »"
        grownupLabel.textAlignment = NSTextAlignment.Center
        grownupLabel.textColor = UIColor.whiteColor()
        grownupLabel.backgroundColor = UIColor(red:0.596, green:0.659, blue:0.757, alpha: 0.7)
        grownupLabel.layer.cornerRadius = 3.0
        grownupLabel.layer.masksToBounds = true
        
        grownupLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(grownupLabel)
        
        grownupLabel.userInteractionEnabled = true
        
        var grownUpTap = UITapGestureRecognizer(target: self, action: Selector("presentGrownUpModal:"))
        grownUpTap.numberOfTapsRequired = 1
        grownupLabel.addGestureRecognizer(grownUpTap)
        
        // grownup constraints
        let labelWidth = NSLayoutConstraint(item: grownupLabel,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 150)
        
        let labelHeight = NSLayoutConstraint(item: grownupLabel,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 25)
        
        let labelX = NSLayoutConstraint(item: grownupLabel,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.TrailingMargin,
            multiplier: 1.0,
            constant: 0)
        
        let labelY = NSLayoutConstraint(item: grownupLabel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.TopMargin,
            multiplier: 1.0,
            constant: 30)
        
        view.addConstraints([buttonHeight,buttonWidth,buttonX,buttonY,labelHeight,labelWidth,labelX,labelY, galleryHeight,galleryTrailing,galleryWidth,galleryY,camHeight,camLeading,camWidth,camY])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

