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
    
    var transformNew = CGAffineTransform()
    
    var leftEyeTestView: UIView!
    var rightEyeTestView: UIView!
    var mouthTestView: UIView!
    var faceTestView: UIView!

    // For testing - print UI Kit coordinates on tap
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let tap = touches.first as! UITouch
        println("tapped at: x: \(tap.locationInView(self.view).x), y: \(tap.locationInView(self.view).y)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // HEIGHT CONSTANTS
        let viewWidth = CGFloat(view.frame.width)
        let imgWidth = imageView.image?.size.width
        let imgHeight2 = CGImageGetHeight(imageView.image!.CGImage)
        let viewHeight = CGFloat(view.frame.height)
        let imgViewHeight = CGFloat(imageView.frame.height)
        let imgHeight = imageView.image?.size.height
        
        var scaleY = viewHeight / imgHeight!
        var scaleX = viewWidth / imgWidth!
        
        //COORDINATE TRANSFORM
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
        

        // CREATE IMAGE DETECTOR, GET FEATURES
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
        
        
        // LOOP THROUGH ALL FACES IN FEATURE ARRAY
        for feature in features{
            
            //context
            var drawCtxt = UIGraphicsGetCurrentContext()
            
            //face
            var faceRect = (feature as! CIFaceFeature).bounds
            
            //UI Kit Coordinates
            var faceOrigin = CGPointApplyAffineTransform(faceRect.origin, transformNew)
            faceTestView.frame.origin.x = faceOrigin.x + (faceRect.width * scaleX)/2.0
            faceTestView.frame.origin.y = faceOrigin.y - (faceRect.height * scaleY)
            
            // CG Coordinates
            faceRect.origin.y = imageView.image!.size.height - faceRect.origin.y - faceRect.size.height
            CGContextSetStrokeColorWithColor(drawCtxt, UIColor.redColor().CGColor)
            CGContextStrokeRect(drawCtxt,faceRect)
            
            // print constants
            println("screen height: \(viewHeight)")
            println("x: \(faceRect.origin.x), y: \(faceRect.origin.y)")
            println("img height: \(imgHeight!), 2: \(imgHeight2), img view height: \(imgViewHeight), scaleY: \(scaleY)")
            println("face height: \(faceRect.height), adjusted height: \(scaleY*faceRect.height)")
            
            view.addSubview(faceTestView)
            
            //mouth
            if((feature.hasMouthPosition) != nil){
                // CG Coordinates
                var mouthRectY = imageView.image!.size.height - feature.mouthPosition.y
                var mouthRect  = CGRectMake(feature.mouthPosition.x - 5,mouthRectY - 5,10,10)
                CGContextSetStrokeColorWithColor(drawCtxt,UIColor.whiteColor().CGColor)
                CGContextStrokeRect(drawCtxt,mouthRect)
                
                // UIKit Coordinates
                var newPosM = CGPointApplyAffineTransform(feature.mouthPosition, transformNew)
                mouthTestView.frame.origin.x = newPosM.x - 2.5
                mouthTestView.frame.origin.y = newPosM.y
                
                view.addSubview(mouthTestView)

            }
            
            //leftEye
            if((feature.hasLeftEyePosition) != nil){
                // CG Coordinates
                var leftEyeRectY = imageView.image!.size.height - feature.leftEyePosition.y
                var leftEyeRect  = CGRectMake(feature.leftEyePosition.x - 5,leftEyeRectY - 5,10,10)
                CGContextSetStrokeColorWithColor(drawCtxt, UIColor.whiteColor().CGColor)
                CGContextStrokeRect(drawCtxt,leftEyeRect)
                
                // UIKit Coordinates
                var newPos = CGPointApplyAffineTransform(feature.leftEyePosition, transformNew)
                leftEyeTestView.frame.origin.x = newPos.x - 2.5
                leftEyeTestView.frame.origin.y = newPos.y
                
                view.addSubview(leftEyeTestView)
            }
            
            //rightEye
            if((feature.hasRightEyePosition) != nil){
                // CG Coordinates
                var rightEyeRectY = imageView.image!.size.height - feature.rightEyePosition.y
                var rightEyeRect  = CGRectMake(feature.rightEyePosition.x - 5,rightEyeRectY - 5,10,10)
                CGContextSetStrokeColorWithColor(drawCtxt, UIColor.whiteColor().CGColor)
                CGContextStrokeRect(drawCtxt,rightEyeRect)
                
                // UIKit Coordinates
                var newPosX = CGPointApplyAffineTransform(feature.rightEyePosition, transformNew)
                rightEyeTestView.frame.origin.x = newPosX.x - 2.5
                rightEyeTestView.frame.origin.y = newPosX.y
                
                view.addSubview(rightEyeTestView)

            }
        }
        
        // add final image to view
        var newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imageView.image = newImage
        imageView.backgroundColor = UIColor(red:0.941, green:0.878, blue:0.000, alpha: 1)
    }
    
}

