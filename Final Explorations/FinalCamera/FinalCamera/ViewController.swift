//
//  ViewController.swift
//  FinalCamera
//
//  Created by Meghan Knoll on 4/11/15.
//  Copyright (c) 2015 Meghan Knoll. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMedia
import CoreVideo
import ImageIO
import QuartzCore

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    let captureSession = AVCaptureSession()
    var captureDevice : AVCaptureDevice?
    var previewLayer : AVCaptureVideoPreviewLayer!
    var faceDetector : CIDetector!
    var videoDataOutput : AVCaptureVideoDataOutput!
    var stillImageOutput = AVCaptureStillImageOutput()
    var devicePosition = AVCaptureDevicePosition.Front
    var videoView : UIView!
    var photoView : UIImageView!
    var swapButton : UIButton!
    var photoButton : UIButton!
    var x_axis : UIView!
    var y_axis : UIView!
    
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    func beginSession() {
        println("Creating Session")
        var err : NSError? = nil
        
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
        captureSession.addOutput(stillImageOutput)
        if err != nil {
            println("error: \(err?.localizedDescription)")
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
        
        videoView.layer.addSublayer(previewLayer)
        println("Preview Layer Created")
        
        previewLayer?.frame = self.view.layer.frame
        captureSession.startRunning()
        println("Session Running")
    }
    
    
    func updateSession() {
        println("Updating Session")
        
        captureSession.beginConfiguration()
        var err : NSError? = nil
        
        
        if captureSession.inputs.count != 0 {
            var input = captureSession.inputs[0] as! AVCaptureInput
            captureSession.removeInput(input)
        }
        
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
        
        if err != nil {
            println("error: \(err?.localizedDescription)")
        }
        
        captureSession.commitConfiguration()
        
    }

    
    func captureImage(){
        var videoConnection :  AVCaptureConnection!
        for connection in stillImageOutput.connections {
            if let tempConnection = connection as? AVCaptureConnection {
            for port in tempConnection.inputPorts {
                if port.mediaType == AVMediaTypeVideo {
                    videoConnection = tempConnection
                    break
                }
            }
            if videoConnection == nil { break }
            }
        }
        
        println("Requesting Capture From \(stillImageOutput)")
        
        stillImageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection) {
            (imageSampleBuffer, error) in // This line defines names the inputs
            var exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, nil)
            
            if exifAttachments != nil {
                println("attachements: \(exifAttachments)")
            } else {
                println("no attachments")
            }
            var imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageSampleBuffer)
        }
    }
    
    func configureDevice() {
        println("Configuring Device")
        if let device = captureDevice {
            if device.isFocusModeSupported(AVCaptureFocusMode.Locked) {
                device.lockForConfiguration(nil)
                device.focusMode = .Locked
                device.unlockForConfiguration()
            }
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("Attempt to Focus")
        
        let tap = touches.first as! UITouch
        var focus_x = tap.locationInView(self.view).x / screenWidth
        var focus_y = tap.locationInView(self.view).y / screenHeight
        
        println("tapped at: \(tap.locationInView(self.view))")
        
        if let device = captureDevice {
            if(device.lockForConfiguration(nil)) {
                if device.focusPointOfInterestSupported && device.isFocusModeSupported(AVCaptureFocusMode.AutoFocus) {
                    device.focusPointOfInterest = CGPoint(x: focus_x,y: focus_y)
                    device.focusMode = .AutoFocus
                    println("set focus to: \(focus_x), \(focus_y)")
                }
                
                if device.exposurePointOfInterestSupported && device.isExposureModeSupported(AVCaptureExposureMode.AutoExpose) {
                    device.exposurePointOfInterest = CGPoint(x: focus_x,y: focus_y)
                    device.exposureMode = .AutoExpose
                    println("set exposure to: \(focus_x), \(focus_y)")
                }
                
                device.unlockForConfiguration()
                
            }
        }
    }
    
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        
        // Set Video Orientation
        if (connection.supportsVideoOrientation){
            connection.videoOrientation = AVCaptureVideoOrientation.Portrait
        }
        if (connection.supportsVideoMirroring) {
            connection.videoMirrored = false
        }
        
        // Get image from the video buffer
        var pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        var attachments : [NSObject : AnyObject] = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, sampleBuffer, CMAttachmentMode(kCMAttachmentMode_ShouldPropagate)).takeRetainedValue() as [NSObject : AnyObject]
        var ciImage = CIImage(CVPixelBuffer: pixelBuffer, options: attachments)
        
        // Get array of features in image
        var featureSet = faceDetector.featuresInImage(ciImage)
        
        // Get clean aperture
        var fdesc = CMSampleBufferGetFormatDescription(sampleBuffer)
        var cleanAperture = CMVideoFormatDescriptionGetCleanAperture(fdesc, 0)
        
    
        // Draw Face
        drawFaces(featureSet, aperture: cleanAperture)
        
        
       // sessionDelegate?.cameraSessionDidOutputSampleBuffer?(sampleBuffer)
    }
    
    func videoPreviewBoxForGravity(gravity: NSString, frameSize:CGSize, apertureSize:CGSize) -> CGRect {
        var apertureRatio = apertureSize.height / apertureSize.width
        var viewRatio = frameSize.width / frameSize.height
        println("Getting Preview")
        var size = CGSizeZero
        
        if gravity == AVLayerVideoGravityResizeAspectFill {
            if (viewRatio > apertureRatio) {
                size.width = frameSize.width
                size.height = apertureSize.width * (frameSize.width / apertureSize.height)
            } else {
                size.width = apertureSize.height * (frameSize.height / apertureSize.width)
                size.height = frameSize.height
            }
        } else if gravity == AVLayerVideoGravityResizeAspect {
            if (viewRatio > apertureRatio) {
                size.width = apertureSize.height * (frameSize.height / apertureSize.width)
                size.height = frameSize.height
            } else {
                size.width = frameSize.width
                size.height = apertureSize.width * (frameSize.width / apertureSize.height)
            }
        } else if gravity == AVLayerVideoGravityResize {
            size.width = frameSize.width
            size.height = frameSize.height
        }
        
        var videoBox = CGRect()
        videoBox.size = size
        if (size.width < frameSize.width){
            videoBox.origin.x = (frameSize.width - size.width) / 2
        }else{
            videoBox.origin.x = (size.width - frameSize.width) / 2
        }
        
        if ( size.height < frameSize.height ){
            videoBox.origin.y = (frameSize.height - size.height) / 2
        }else{
            videoBox.origin.y = (size.height - frameSize.height) / 2
        }
        
        return videoBox
    }
    
    func drawFaces(features: [AnyObject], aperture: CGRect ){
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        
        x_axis.alpha = 0
        y_axis.alpha = 0
        
        if features.count == 0 {
            CATransaction.commit()
            return
        }
        
        var parentFrameSize = self.videoView.frame.size
        var gravity = previewLayer!.videoGravity
        var previewBox = videoPreviewBoxForGravity(gravity, frameSize: parentFrameSize, apertureSize: aperture.size)
        var isMirrored = true
        println("Preview Success")
        
        for feature in features {
             println("Found Feature")
            let face:CIFaceFeature = feature as! CIFaceFeature
            var origin_x = face.bounds.origin.x
            var origin_y = face.bounds.origin.y + 45
            var fwidth = face.bounds.width
            var fheight = face.bounds.height
            var faceRect = feature.bounds
            
            //var widthScaleBy = previewBox.size.width / aperture.size.height
            //var heightScaleBy = previewBox.size.height / aperture.size.width
            
            //fwidth = fwidth * widthScaleBy
            //fheight = fheight * heightScaleBy
            
            
            /*if isMirrored {
                origin_x = prev
            iewBox.origin.x + previewBox.size.width - fwidth - (origin_x * 2)
                origin_y = previewBox.origin.y
            }else{
                origin_x = previewBox.origin.x
                origin_y = previewBox.origin.y
            }*/
            
            let center_x = (origin_x + fwidth/2.0)
            let center_y = (origin_y + fheight/2.0)
            
            x_axis.alpha = 0.5
            y_axis.alpha = 0.5
            x_axis.frame = CGRect(x: center_x - 2, y: origin_y, width: 4, height: fheight)
            y_axis.frame = CGRect(x: origin_x, y: center_y - 2, width: fwidth, height: 4)
            
            println("Face found at (\(origin_x),\(origin_y)) of dimensions \(fwidth)x\(fheight)")
        }
        CATransaction.commit()
    }
    
    func createVideoSwapButton(){
        swapButton = UIButton()
        swapButton.setTitle("Swap", forState: .Normal)
        swapButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        swapButton.addTarget(self, action: "swapPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(swapButton)

        //OUTPUT LABEL CONSTRAINTS
        let buttonWConstraint = NSLayoutConstraint(item: swapButton,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 50)
        
        let buttonHConstraint = NSLayoutConstraint(item: swapButton,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier:1,
            constant: 30)
        
        let buttonLeading = NSLayoutConstraint(item: swapButton,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.LeadingMargin,
            multiplier: 1.0,
            constant: 0)
        
        let buttonTop = NSLayoutConstraint(item: swapButton,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.TopMargin,
            multiplier: 1.0,
            constant: 30)
        
        view.addConstraints([buttonWConstraint,buttonHConstraint, buttonLeading,buttonTop])
    }
    
    func createPhotoButton(){
        photoButton = UIButton()
        photoButton.setTitle("Snap", forState: .Normal)
        photoButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        photoButton.addTarget(self, action: "photoPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(photoButton)
        
        //OUTPUT LABEL CONSTRAINTS
        let buttonWConstraint = NSLayoutConstraint(item: photoButton,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: 50)
        
        let buttonHConstraint = NSLayoutConstraint(item: photoButton,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier:1,
            constant: 30)
        
        let buttonLeading = NSLayoutConstraint(item: photoButton,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.TrailingMargin,
            multiplier: 1.0,
            constant: 0)
        
        let buttonTop = NSLayoutConstraint(item: photoButton,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.TopMargin,
            multiplier: 1.0,
            constant: 30)
        
        view.addConstraints([buttonWConstraint,buttonHConstraint, buttonLeading,buttonTop])
    }

    func swapPressed(sender: AnyObject){
        devicePosition = devicePosition == .Front ? .Back : .Front
        findDevice(devicePosition)
        if captureDevice != nil {
            updateSession()
        }
    }
    
    func photoPressed(sender: AnyObject){
        captureImage()
    }
    
    func createMainVideoView(){
        videoView = UIView()
        videoView.backgroundColor = UIColor(red:0.655, green:0.769, blue:0.941, alpha: 1)
        videoView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(videoView)
        
        //OUTPUT LABEL CONSTRAINTS
        let videoWConstraint = NSLayoutConstraint(item: videoView,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: 0)
        
        let videoHConstraint = NSLayoutConstraint(item: videoView,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Height,
            multiplier:1,
            constant: 0)
        
        let videoLeading = NSLayoutConstraint(item: videoView,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 0)
        
        let videoTop = NSLayoutConstraint(item: videoView,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 0)
        
        view.addConstraints([videoWConstraint,videoHConstraint, videoLeading,videoTop])
        
    }
    
    func createPhotoView(){
        photoView = UIImageView()
        /*photoView.backgroundColor = UIColor(red:0.655, green:0.769, blue:0.941, alpha: 1)
        photoView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(photoView)
        
        //OUTPUT LABEL CONSTRAINTS
        let videoWConstraint = NSLayoutConstraint(item: videoView,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: 0)
        
        let videoHConstraint = NSLayoutConstraint(item: videoView,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Height,
            multiplier:1,
            constant: 0)
        
        let videoLeading = NSLayoutConstraint(item: videoView,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 0)
        
        let videoTop = NSLayoutConstraint(item: videoView,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Top,
            multiplier: 1.0,
            constant: 0)
        
        view.addConstraints([videoWConstraint,videoHConstraint, videoLeading,videoTop])*/
        
    }

    func findDevice(position : AVCaptureDevicePosition) {
        let devices = AVCaptureDevice.devices()
        
        for device in devices {
            if (device.hasMediaType(AVMediaTypeVideo)) {
                if(device.position == position) {
                    captureDevice = device as? AVCaptureDevice
                    println("Found Camera")
                }
            }
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createMainVideoView()
        createVideoSwapButton()
        createPhotoButton()
        
        x_axis = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        x_axis.backgroundColor = UIColor(red:0.655, green:0.769, blue:0.941, alpha: 1)
        
        y_axis = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        y_axis.backgroundColor = UIColor(red:0.655, green:0.769, blue:0.941, alpha: 1)
        
        view.addSubview(x_axis)
        view.addSubview(y_axis)
        
        captureSession.sessionPreset = AVCaptureSessionPresetMedium
        faceDetector = CIDetector(ofType:CIDetectorTypeFace, context:nil, options:[CIDetectorAccuracy: CIDetectorAccuracyLow])
        
        findDevice(devicePosition)
        
        if captureDevice != nil {
            configureDevice()
            beginSession()
        }
        
        var videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL)
        
        videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey: kCVPixelFormatType_32BGRA]
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)

        
        if captureSession.canAddOutput(videoDataOutput) {
            captureSession.addOutput(videoDataOutput)
            println("Added Video Ouput")
        }
        
        videoDataOutput.connectionWithMediaType(AVMediaTypeVideo)
        
    }


}

