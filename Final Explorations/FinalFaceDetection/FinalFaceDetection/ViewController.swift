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
    var compositeImage : UIImage!
    var eyeImageView: UIImageView!
    var mouthImageView: UIImageView!
    var hatImageView: UIImageView!
    
    func getEyeBounds(pos: CGPoint) -> CGRect {
        return CGRect()
    }
  
    @IBAction func compositeImage(sender: AnyObject) {
        var eyeBounds = CGRectMake(eyeImageView.bounds.origin.x, eyeImageView.bounds.origin.y, eyeImageView.image!.size.width, eyeImageView.image!.size.height)
        var mouthBounds = CGRectMake(0, 0, mouthImageView.image!.size.width, mouthImageView.image!.size.height)
        var hatBounds = CGRectMake(0, 0, hatImageView.image!.size.width, hatImageView.image!.size.height)
        var mainBounds = CGRectMake(0, 0, imageView.image!.size.width, imageView.image!.size.height)
        
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
        imageView.image = compositeImage
        
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
        transform = CGAffineTransformTranslate(transform, 0, -bounds.size.height)
        let newPos = CGPointApplyAffineTransform(pos, transform)
        
        mouthImageView = UIImageView(image: UIImage(named: "mouth_adjusted_fangs.png"))
        mouthImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        mouthImageView.contentMode = UIViewContentMode.ScaleAspectFit
        view.addSubview(mouthImageView)
        
        var tempHeight = bounds.height * 0.30
        var tempY = (pos.y / 2.0) + 40
        
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
            toItem: imageView,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: newPos.y + 10)
        
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transform = CGAffineTransformMakeScale(1, -1)
        // transform = CGAffineTransformTranslate(transform, 0, -imageView.bounds.size.height)
        
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
            
            createHatImage(faceRect)
            
            //mouth
            if((feature.hasMouthPosition) != nil){
                var mouseRectY = imageView.image!.size.height - feature.mouthPosition.y
                var mouseRect  = CGRectMake(feature.mouthPosition.x - 5,mouseRectY - 5,10,10)
                CGContextSetStrokeColorWithColor(drawCtxt,UIColor.blueColor().CGColor)
                CGContextStrokeRect(drawCtxt,mouseRect)
                createMouthImage(feature.mouthPosition, bounds: faceRect)
            }
            
            //leftEye
            if((feature.hasLeftEyePosition) != nil){
                var eyeRect = getEyeBounds(feature.leftEyePosition)
                var leftEyeRectY = imageView.image!.size.height - feature.leftEyePosition.y
                var leftEyeRect  = CGRectMake(feature.leftEyePosition.x - 5,leftEyeRectY - 5,10,10)
                CGContextSetStrokeColorWithColor(drawCtxt, UIColor.blueColor().CGColor)
                CGContextStrokeRect(drawCtxt,leftEyeRect)
                println(leftEyeRectY)
                createEyeImage(feature.leftEyePosition, bounds: faceRect)
            }
            
            //rightEye
            if((feature.hasRightEyePosition) != nil){
                var rightEyeRectY = imageView.image!.size.height - feature.rightEyePosition.y
                var rightEyeRect  = CGRectMake(feature.rightEyePosition.x - 5,rightEyeRectY - 5,10,10)
                CGContextSetStrokeColorWithColor(drawCtxt, UIColor.blueColor().CGColor)
                CGContextStrokeRect(drawCtxt,rightEyeRect)
            }
        }
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = newImage
    }
    
}

