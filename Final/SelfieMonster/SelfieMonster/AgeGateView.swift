//
//  AgeGateView.swift
//  SelfieMonster
//
//  Created by Meghan Knoll on 5/1/15.
//  Copyright (c) 2015 Meghan Knoll. All rights reserved.
//

import UIKit

class AgeGateView: UIViewController {
    
    var exitButton : UIButton!
    var modalView : UIView!
    var buttonGrid : UIView!
    
    var descriptionLabel : UILabel!
    var titleLabel: UILabel!
    var numLabel: UILabel!
    
    var gateLabelOne:UILabel!
    var gateLabelTwo:UILabel!
    var gateLabelThree:UILabel!
    
    var numberMap  = ["ZERO","ONE","TWO","THREE","FOUR","FIVE","SIX","SEVEN","EIGHT","NINE"]
    var gateNumbers = [Int]()
    
    func dismissModal(sender : AnyObject){
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    func createButtons(){
        var button = UIButton()
        button.backgroundColor = UIColor(red:0.945, green:0.522, blue:0.467, alpha: 1)
        button.layer.cornerRadius = button.frame.size.width/2
        button.clipsToBounds = true
    }
    
    func generateNumbers(){
        let one = Int(arc4random_uniform(9)) + 1
        let two = Int(arc4random_uniform(9)) + 1
        let three = Int(arc4random_uniform(9)) + 1
        gateNumbers = [one,two,three]
        numLabel.text = "\(numberMap[one]), \(numberMap[two]), \(numberMap[three])"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .Custom
        view.backgroundColor = UIColor(red:0.459, green:0.522, blue:0.620, alpha: 0.7)
        
        modalView = UIView()
        
        modalView.layer.cornerRadius = 3.0
        modalView.layer.masksToBounds = true
        modalView.layer.borderColor = UIColor(red:0.945, green:0.522, blue:0.467, alpha: 1).CGColor
        modalView.layer.borderWidth = 5.0
        
        let backgroundTile : UIImage = UIImage(named:"background_linen.png")!
        modalView.backgroundColor = UIColor(patternImage: backgroundTile)
        
        modalView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(modalView)
        
        
        // grownup constraints
        let modalWidth = NSLayoutConstraint(item: modalView,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Width,
            multiplier: 0.8,
            constant: 1)
        
        let modalHeight = NSLayoutConstraint(item: modalView,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Height,
            multiplier: 0.6,
            constant: 1)
        
        let modalX = NSLayoutConstraint(item: modalView,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0)
        
        let modalY = NSLayoutConstraint(item: modalView,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 1.0,
            constant: 0)

        
        exitButton = UIButton()
        exitButton.setImage(UIImage(named: "exit_button_2x.png"), forState:.Normal)
        exitButton.setImage(UIImage(named: "exit_button_2x_pressed.png"), forState:.Highlighted)
        exitButton.addTarget(self, action: "dismissModal:", forControlEvents: UIControlEvents.TouchUpInside)
        exitButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(exitButton)
        
        // cam constraints
        let exitLeading = NSLayoutConstraint(item: exitButton,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: modalView,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 10)
        
        let exitHeight = NSLayoutConstraint(item: exitButton,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 35)
        
        let exitWidth = NSLayoutConstraint(item: exitButton,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 35)
        
        let exitY = NSLayoutConstraint(item: exitButton,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: modalView,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: -10)

        
        titleLabel = UILabel()
        titleLabel.font = UIFont(name: "ArialRoundedMTBold", size: 18.0)
        titleLabel.text = "This is for Grown-Ups Only!"
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(titleLabel)
        
        let titleX = NSLayoutConstraint(item: titleLabel,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: modalView,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0)
        
        let titleHeight = NSLayoutConstraint(item: titleLabel,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 30)
        
        let titleWidth = NSLayoutConstraint(item: titleLabel,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: modalView,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: 0)
        
        let titleY = NSLayoutConstraint(item: titleLabel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: modalView,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 20)
        
        descriptionLabel = UILabel()
        descriptionLabel.font = UIFont(name: "ArialRoundedMTBold", size: 14.0)
        descriptionLabel.text = "To continue, enter the numbers:"
        descriptionLabel.textAlignment = NSTextAlignment.Center
        descriptionLabel.textColor = UIColor.blackColor()
        descriptionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(descriptionLabel)
        
        let descriptionX = NSLayoutConstraint(item: descriptionLabel,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: modalView,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0)
        
        let descriptionHeight = NSLayoutConstraint(item: descriptionLabel,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 20)
        
        let descriptionWidth = NSLayoutConstraint(item: descriptionLabel,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: modalView,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: 0)
        
        let descriptionY = NSLayoutConstraint(item: descriptionLabel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: titleLabel,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 20)
        
        numLabel = UILabel()
        numLabel.font = UIFont(name: "ArialRoundedMTBold", size: 18.0)
        numLabel.textAlignment = NSTextAlignment.Center
        numLabel.text = "ONE, TWO, THREE"
        //numLabel.textColor = UIColor.blackColor()
        generateNumbers()
        numLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(numLabel)
        generateNumbers()

        let numX = NSLayoutConstraint(item: numLabel,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: modalView,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0)
        
        let numHeight = NSLayoutConstraint(item: numLabel,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 30)
        
        let numWidth = NSLayoutConstraint(item: numLabel,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: modalView,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: 0)
        
        let numY = NSLayoutConstraint(item: numLabel,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: descriptionLabel,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 5)
        
        
        gateLabelOne = UILabel()
        gateLabelOne.backgroundColor = UIColor.whiteColor()
        gateLabelOne.layer.cornerRadius = 3.0
        gateLabelOne.layer.masksToBounds = true
        gateLabelOne.layer.borderColor = UIColor(red:0.749, green:0.769, blue:0.722, alpha: 1).CGColor
        gateLabelOne.layer.borderWidth = 2.0
        gateLabelOne.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        gateLabelTwo = UILabel()
        gateLabelTwo.backgroundColor = UIColor.whiteColor()
        gateLabelTwo.layer.cornerRadius = 3.0
        gateLabelTwo.layer.masksToBounds = true
        gateLabelTwo.layer.borderColor = UIColor(red:0.749, green:0.769, blue:0.722, alpha: 1).CGColor
        gateLabelTwo.layer.borderWidth = 2.0
        gateLabelTwo.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        gateLabelThree = UILabel()
        gateLabelThree.backgroundColor = UIColor.whiteColor()
        gateLabelThree.layer.cornerRadius = 3.0
        gateLabelThree.layer.masksToBounds = true
        gateLabelThree.layer.borderColor = UIColor(red:0.749, green:0.769, blue:0.722, alpha: 1).CGColor
        gateLabelThree.layer.borderWidth = 2.0
        gateLabelThree.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        view.addSubview(gateLabelOne)
        view.addSubview(gateLabelTwo)
        view.addSubview(gateLabelThree)
        
        let glOneX = NSLayoutConstraint(item: gateLabelOne,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: gateLabelTwo,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: -10)
        
        let glOneHeight = NSLayoutConstraint(item: gateLabelOne,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 50)
        
        let glOneWidth = NSLayoutConstraint(item: gateLabelOne,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 40)
        
        let glOneY = NSLayoutConstraint(item: gateLabelOne,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: gateLabelTwo,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 0)

        let glTwoX = NSLayoutConstraint(item: gateLabelTwo,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: modalView,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0)
        
        let glTwoHeight = NSLayoutConstraint(item: gateLabelTwo,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 50)
        
        let glTwoWidth = NSLayoutConstraint(item: gateLabelTwo,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 40)
        
        let glTwoY = NSLayoutConstraint(item: gateLabelTwo,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: numLabel,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 5)

        let glThreeX = NSLayoutConstraint(item: gateLabelThree,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: gateLabelTwo,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 10)
        
        let glThreeHeight = NSLayoutConstraint(item: gateLabelThree,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 50)
        
        let glThreeWidth = NSLayoutConstraint(item: gateLabelThree,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 40)
        
        let glThreeY = NSLayoutConstraint(item: gateLabelThree,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: gateLabelTwo,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 0)

        buttonGrid = UIView()
        buttonGrid.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(buttonGrid)
        
        let gridX = NSLayoutConstraint(item: buttonGrid,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: modalView,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0)
        
        let gridTop = NSLayoutConstraint(item: buttonGrid,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: modalView,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: -10)
        
        let gridWidth = NSLayoutConstraint(item: buttonGrid,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: modalView,
            attribute: NSLayoutAttribute.Width,
            multiplier: 0.8,
            constant: 0)
        
        let gridBottom = NSLayoutConstraint(item: buttonGrid,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: gateLabelTwo,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1.0,
            constant: 10)
        
        view.addConstraints([modalWidth,modalHeight, modalX, modalY,
                            exitLeading, exitHeight, exitWidth, exitY,
                            numX, numHeight,numWidth,numY,
                            titleX, titleHeight, titleWidth, titleY,
                            descriptionX, descriptionHeight, descriptionWidth, descriptionY,
                            glOneX,glOneY,glOneHeight,glOneWidth,
                            glThreeHeight,glThreeWidth,glThreeX,glThreeY,
                            glTwoHeight,glTwoWidth,glTwoX,glTwoY,
                            gridBottom,gridWidth,gridTop,gridX])
        
        createButtons()
    }

}
