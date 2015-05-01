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
    
    func camPressed(sender: AnyObject){
        println("camera")
    }
    
    func monsterPressed(sender: AnyObject){
        println("monster")
    }
    
    func galleryPressed(sender: AnyObject){
        println("gallery")
    }
    
    func initStarAnimation() {
        var starView = StarView(frame: CGRect(x:60,y:80,width:20,height:20))
        starView.drawStar(20,sides: 10)
        view.addSubview(starView)
        
        var starView1 = StarView(frame: CGRect(x:320,y:60,width:20,height:20))
        starView1.drawStar(10,sides: 8)
        view.addSubview(starView1)
        
        var starView2 = StarView(frame: CGRect(x:170,y:135,width:20,height:20))
        starView2.drawStar(10,sides: 5)
        view.addSubview(starView2)
        
        var starView3 = StarView(frame: CGRect(x:20,y:260,width:20,height:20))
        starView3.drawStar(10,sides: 8)
        view.addSubview(starView3)
        
        var starView4 = StarView(frame: CGRect(x:150,y:250,width:20,height:20))
        starView4.drawStar(15,sides: 5)
        view.addSubview(starView4)
        
        var starView5 = StarView(frame: CGRect(x:360,y:300,width:20,height:20))
        starView5.drawStar(20,sides: 8)
        view.addSubview(starView5)
        
        var starView6 = StarView(frame: CGRect(x:120,y:445,width:20,height:20))
        starView6.drawStar(15,sides: 10)
        view.addSubview(starView6)
        
        var starView7 = StarView(frame: CGRect(x:320,y:500,width:20,height:20))
        starView7.drawStar(20,sides: 8)
        view.addSubview(starView7)
        
        var starView8 = StarView(frame: CGRect(x:50,y:540,width:20,height:20))
        starView8.drawStar(10,sides: 5)
        view.addSubview(starView8)
        
        var starScape = [starView,starView1,starView2,starView3,starView4,starView5,starView6,starView7,starView8]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundTile : UIImage = UIImage(named:"background_fibers.jpg")!
        self.view.backgroundColor = UIColor(patternImage: backgroundTile)
        
        
        initStarAnimation()
        
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
        monsterButton.setImage(UIImage(named: "big_button_monster.png"), forState:.Normal)
        monsterButton.setImage(UIImage(named: "big_button_monster_presed.png"), forState:.Highlighted)
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

