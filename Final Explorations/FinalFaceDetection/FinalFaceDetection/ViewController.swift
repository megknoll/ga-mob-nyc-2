//
//  ViewController.swift
//  FinalFaceDetection
//
//  Created by Meghan Knoll on 4/18/15.
//  Copyright (c) 2015 Meghan Knoll. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    var transform = CGAffineTransform()
    var transformNew = CGAffineTransform()
    var compositeImage : UIImage!
    var eyeImageView: UIImageView!
    var leftEyeTestView: UIView!
    var rightEyeTestView: UIView!
    var mouthTestView: UIView!
    var faceTestView: UIView!

    var mouthImageView: UIImageView!
    var hatImageView: UIImageView!
    
    func getEyeBounds(pos: CGPoint) -> CGRect {
        return CGRect()
    }
  
    @IBAction func compositeImage(sender: AnyObject) {
        var mainBounds = CGRectMake(0, 0, imageView.image!.size.width, imageView.image!.size.height)
        var eyeBounds = CGRectMake(0, eyeImageView.bounds.origin.y, eyeImageView.image!.size.width, eyeImageView.image!.size.height)
        var mouthBounds = CGRectMake(0, mouthImageView.bounds.origin.y, mouthImageView.image!.size.width, mouthImageView.image!.size.height)
        var hatBounds = CGRectMake(0, 500, hatImageView.image!.size.width, hatImageView.image!.size.height)
        println("EYEBALLS: \(eyeImageView.bounds.origin.y)")
        
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedFirst.rawValue)
        
        var ctx = CGBitmapContextCreate(nil,
            CGImageGetWidth(imageView.image!.CGImage),
            CGImageGetHeight(imageView.image!.CGImage),
            CGImageGetBitsPerComponent(imageView.image!.CGImage),
            CGImageGetBytesPerRow(imageView.image!.CGImage),
            CGImageGetColorSpace(imageView.image!.CGImage),
            bitmapInfo)!
        
        CGContextDrawImage(ctx, mainBounds, (imageView.image!.CGImage))
        CGContextSetBlendMode(ctx, kCGBlendModeNormal)
        CGContextDrawImage(ctx, eyeBounds, eyeImageView.image!.CGImage)
        CGContextDrawImage(ctx, mouthBounds, mouthImageView.image!.CGImage)
        CGContextDrawImage(ctx, hatBounds, hatImageView.image!.CGImage)
        compositeImage = UIImage(CGImage: CGBitmapContextCreateImage(ctx))!
        
        UIImageWriteToSavedPhotosAlbum(compositeImage, nil, nil, nil)
        
        self.performSegueWithIdentifier("saveSegue", sender: self)
    }
    
    func createHatImage(bounds: CGRect) {
        
        hatImageView = UIImageView(image: UIImage(named: "hat_adjusted_crown.png"))
        hatImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        hatImageView.contentMode = UIViewContentMode.ScaleAspectFit
        view.addSubview(hatImageView)
        
        var tempHeight = bounds.height * 0.40
        var tempY = bounds.origin.y / 2.0 - 20.0
        
        let widthConstraint = NSLayoutConstraint(item: hatImageView,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: imageView,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: 0)
        
        let trailingConstraint = NSLayoutConstraint(item: hatImageView,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: imageView,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 0)
        
        let heightConstraint = NSLayoutConstraint(item: hatImageView,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: tempHeight)
        
        let topConstraint = NSLayoutConstraint(item: hatImageView,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: imageView,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: tempY)
        
        println("height: \(tempHeight), screen height: \(imageView.bounds.height)")
        view.addConstraints([topConstraint, heightConstraint,widthConstraint,trailingConstraint])
    }

    func createMouthImage(pos: CGPoint, bounds: CGRect) {
        //transform = CGAffineTransformTranslate(transform, 0, -bounds.size.height)
        let newPos = CGPointApplyAffineTransform(pos, transformNew)
        
        mouthImageView = UIImageView(image: UIImage(named: "mouth_adjusted_fangs.png"))
        mouthImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        mouthImageView.contentMode = UIViewContentMode.ScaleAspectFit
        view.addSubview(mouthImageView)
        
        var imageAdjustment = mouthImageView.image?.size.height
        var tempHeight = bounds.height * 0.30
        var tempY = newPos.y - (imageAdjustment!/4.0)
        
        let widthConstraint = NSLayoutConstraint(item: mouthImageView,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: imageView,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: 0)
        
        let trailingConstraint = NSLayoutConstraint(item: mouthImageView,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: imageView,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 0)
        
        let heightConstraint = NSLayoutConstraint(item: mouthImageView,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: tempHeight)
        
        let topConstraint = NSLayoutConstraint(item: mouthImageView,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: tempY)
        
        println("mouth: y:\(tempY), tY:\(newPos.y), height: \(tempHeight), screen height: \(imageView.bounds.height)")
        view.addConstraints([topConstraint, heightConstraint,widthConstraint,trailingConstraint])
    }
    
    func createEyeImage(pos: CGPoint, bounds: CGRect) {
        //transform = CGAffineTransformTranslate(transform, 0, -bounds.size.height)
        let newPos = CGPointApplyAffineTransform(pos, transform)
        
        eyeImageView = UIImageView(image: UIImage(named: "eyes_adjusted_robot.png"))
        eyeImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        eyeImageView.contentMode = UIViewContentMode.ScaleAspectFit
        view.addSubview(eyeImageView)
        
        
        var tempHeight = bounds.height * 0.30
        var tempY = (pos.y / 2.0) - tempHeight
        
        let widthConstraint = NSLayoutConstraint(item: eyeImageView,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: imageView,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: 0)
        
        let trailingConstraint = NSLayoutConstraint(item: eyeImageView,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: imageView,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 0)
        
        let heightConstraint = NSLayoutConstraint(item: eyeImageView,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: tempHeight)
        
        let topConstraint = NSLayoutConstraint(item: eyeImageView,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: imageView,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: tempY)
        
        println("eyes: y:\(tempY), tY:\(newPos.y), height: \(tempHeight), screen height: \(imageView.bounds.height)")
        view.addConstraints([topConstraint, heightConstraint,widthConstraint,trailingConstraint])
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        
        if segue.identifier == "saveSegue" {
            var destination = segue.destinationViewController as! SaveViewController
            
            if compositeImage != nil{
                println("success")
                destination.compositeImage = compositeImage
            }
        }
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let tap = touches.first as! UITouch
        println("tapped at: x: \(tap.locationInView(self.view).x), y: \(tap.locationInView(self.view).y)")
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var viewWidth = CGFloat(view.frame.width)
        var imgWidth = imageView.image?.size.width
        var viewHeight = CGFloat(view.frame.height)
        var imgViewHeight = CGFloat(imageView.frame.height)
        var imgHeight = imageView.image?.size.height
        var labelHeight = imageLabel.frame.height
        
        var scaleY = viewHeight / imgHeight! //(view.frame.height-110) / imgHeight!
        var scaleX = viewWidth / imgWidth!
        
        transformNew = CGAffineTransformMakeScale(scaleX, -scaleY)
        transformNew = CGAffineTransformTranslate(transformNew, 0, (-1 * imgHeight!))
        
        
        // SET UP TEST FRAMES
        leftEyeTestView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        leftEyeTestView.backgroundColor = UIColor(red:0.561, green:0.957, blue:0.906, alpha: 1) // light green
        rightEyeTestView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        rightEyeTestView.backgroundColor = UIColor(red:0.102, green:0.914, blue:0.808, alpha: 1) // green
        mouthTestView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        mouthTestView.backgroundColor = UIColor(red:1.000, green:0.251, blue:0.220, alpha: 1) // red
        faceTestView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        faceTestView.backgroundColor = UIColor(red:0.941, green:0.878, blue:0.000, alpha: 1) // yellow
        

        
        // CREATE DETECTORY & IMAGE
        var ciImage  = CIImage(CGImage:imageView.image!.CGImage)
        var ciDetector = CIDetector(ofType:CIDetectorTypeFace
            ,context:nil
            ,options:[
                CIDetectorAccuracy:CIDetectorAccuracyHigh,
                CIDetectorSmile:true
            ]
        )
        var features = ciDetector.featuresInImage(ciImage)
        
        UIGraphicsBeginImageContext(imageView.image!.size)
        imageView.image!.drawInRect(CGRectMake(0,0,imageView.image!.size.width,imageView.image!.size.height))
        
        for feature in features{
            
            //context
            var drawCtxt = UIGraphicsGetCurrentContext()
            
            //face
            var faceRect = (feature as! CIFaceFeature).bounds
            faceRect.origin.y = imageView.image!.size.height - faceRect.origin.y - faceRect.size.height
            CGContextSetStrokeColorWithColor(drawCtxt, UIColor.redColor().CGColor)
            CGContextStrokeRect(drawCtxt,faceRect)
            
            var faceOrigin = CGPointApplyAffineTransform(faceRect.origin, transformNew)
            faceTestView.frame.origin.x = faceOrigin.x + (faceRect.width * scaleX)/2.0
            faceTestView.frame.origin.y = faceOrigin.y - (faceRect.height/2.0 * scaleY)
            println("label height: \(labelHeight), screen height: \(viewHeight)")
            println("x: \(faceRect.origin.x), y: \(faceRect.origin.y)")
            println("img height: \(imgHeight!), img view height: \(imgViewHeight), scaleY: \(scaleY)")
            println("face height: \(faceRect.height), adjusted height: \(scaleY*faceRect.height)")
            
            view.addSubview(faceTestView)
            //createHatImage(faceRect)
            
            //mouth
            if((feature.hasMouthPosition) != nil){
                
                // Frame Coordinates
                var mouseRectY = imageView.image!.size.height - feature.mouthPosition.y
                var mouseRect  = CGRectMake(feature.mouthPosition.x - 5,mouseRectY - 5,10,10)
                CGContextSetStrokeColorWithColor(drawCtxt,UIColor.whiteColor().CGColor)
                CGContextStrokeRect(drawCtxt,mouseRect)
                
                // My Coordinates
                var newPosM = CGPointApplyAffineTransform(feature.mouthPosition, transformNew)
                mouthTestView.frame.origin.x = newPosM.x
                mouthTestView.frame.origin.y = newPosM.y
                view.addSubview(mouthTestView)
                
               // createMouthImage(feature.mouthPosition, bounds: faceRect)

            }
            
            //leftEye
            if((feature.hasLeftEyePosition) != nil){
                var leftEyeRectY = imageView.image!.size.height - feature.leftEyePosition.y
                var leftEyeRect  = CGRectMake(feature.leftEyePosition.x - 5,leftEyeRectY - 5,10,10)
                CGContextSetStrokeColorWithColor(drawCtxt, UIColor.whiteColor().CGColor)
                CGContextStrokeRect(drawCtxt,leftEyeRect)
                
                var newPos = CGPointApplyAffineTransform(feature.leftEyePosition, transformNew)
                leftEyeTestView.frame.origin.x = newPos.x
                leftEyeTestView.frame.origin.y = newPos.y
                
                /*println("original x: \(feature.leftEyePosition.x), y: \(feature.leftEyePosition.y)")
                println("translated x: \(newPos.x), y: \(newPos.y)")
                println("other translation y: \(leftEyeRectY)")*/
               
                
                view.addSubview(leftEyeTestView)
                //createEyeImage(feature.leftEyePosition, bounds: faceRect)
            }
            
            //rightEye
            if((feature.hasRightEyePosition) != nil){
                var rightEyeRectY = imageView.image!.size.height - feature.rightEyePosition.y
                var rightEyeRect  = CGRectMake(feature.rightEyePosition.x - 5,rightEyeRectY - 5,10,10)
                
                var newPosX = CGPointApplyAffineTransform(feature.rightEyePosition, transformNew)
                CGContextSetStrokeColorWithColor(drawCtxt, UIColor.whiteColor().CGColor)
                CGContextStrokeRect(drawCtxt,rightEyeRect)
                
                rightEyeTestView.frame.origin.x = newPosX.x
                rightEyeTestView.frame.origin.y = newPosX.y
                view.addSubview(rightEyeTestView)
                /*println("translated x: \(newPosX.x), y: \(newPosX.y)")*/
            }
        }
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = newImage
        imageView.backgroundColor = UIColor(red:0.941, green:0.878, blue:0.000, alpha: 1)
    }
    
}

