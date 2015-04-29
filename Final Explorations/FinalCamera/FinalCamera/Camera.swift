//
//  CaptureManager.swift
//  Cloak
//
//  Created by Raman Nanda on 11/13/14.
//  Copyright (c) 2014 Raman Nanda. All rights reserved.
//

import Foundation
import AVFoundation
import AssetsLibrary

class CaptureManager: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    private(set) var isSessionActive: Bool = false
    private(set) var isFrontCameraActive: Bool = true
    private(set) var isFlashActive: Bool = false
    private(set) var isCapturing = false
    
    private let START_INDEX = 0
    private var frameIndex = 0
    private let FRAME_COUNT = 180
    private let FRAME_INTERVAL = 10
    private let OUTPUT_TIMESCALE:Int32 = 540
    private let OUTPUT_FRAMESIZE:Int64 = 60
    private var assetURL: NSURL!
    
    var delegate: CaptureManagerDelegate?
    
    var session: AVCaptureSession!
    var connection: AVCaptureConnection!
    var captureQueue :dispatch_queue_t!
    var assetWriter: AVAssetWriter!
    var assetInput: AVAssetWriterInput!
    
    let VIDEO_OUTPUT_SETTINGS: Dictionary<String, AnyObject> = [
        AVVideoCodecKey : AVVideoCodecH264,
        AVVideoWidthKey : 640,
        AVVideoHeightKey : 640,
        AVVideoScalingModeKey: AVVideoScalingModeResizeAspectFill
    ];
    
    let VIDEO_CAPTURE_SETTINGS = AVCaptureSessionPresetHigh
    let QUEUE_LABEL = "com.mtvn.cloak.capture"
    
    class var sharedInstance: CaptureManager {
        struct Static {
            static let instance: CaptureManager = CaptureManager()
        }
        return Static.instance
    }
    
    private func cameraWithPosition(position: AVCaptureDevicePosition) -> AVCaptureDevice? {
        var captureDevice: AVCaptureDevice?
        var devices: NSArray = AVCaptureDevice.devices()
        for device: AnyObject in devices {
            if (device.position == position && device.hasMediaType(AVMediaTypeVideo)) {
                captureDevice = device as? AVCaptureDevice
            }
        }
        return captureDevice
    }
    
    // MARK: - Session Management
    
    func startSession() -> AVCaptureSession? {
        session = AVCaptureSession()
        session.beginConfiguration()
        
        var captureDevice: AVCaptureDevice? = cameraWithPosition(AVCaptureDevicePosition.Front)
        if(captureDevice == nil) {
            return nil
        }
        
        var err = NSErrorPointer()
        var newVideoInput = AVCaptureDeviceInput(device: captureDevice, error: err)
        if(err != nil) {
            println("Error: \(err.debugDescription)")
        }
        
        session?.addInput(newVideoInput)
        
        captureQueue = dispatch_queue_create(QUEUE_LABEL, DISPATCH_QUEUE_SERIAL)
        var videoOutput:AVCaptureVideoDataOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: captureQueue)
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey : kCMPixelFormat_32BGRA]
        session.addOutput(videoOutput)
        
        
        if session != nil && session!.canSetSessionPreset(self.VIDEO_CAPTURE_SETTINGS) {
            session?.sessionPreset = self.VIDEO_CAPTURE_SETTINGS
        }
        
        var connection = videoOutput.connectionWithMediaType(AVMediaTypeVideo)
        if connection != nil && connection!.supportsVideoOrientation {
            connection!.videoOrientation = AVCaptureVideoOrientation.Portrait
        }
        
        session.commitConfiguration()
        session.startRunning()
        isSessionActive = true
        return session
    }
    
    func endSession() {
        isSessionActive = false
    }
    
    // MARK: - Control Management
    
    func swapCamera(useFrontCamera: Bool?) {
        
        if(useFrontCamera == nil) {
            if(isFrontCameraActive) {
                swapCameraInput(false)
            } else {
                swapCameraInput(true)
            }
        } else {
            swapCameraInput(useFrontCamera!)
        }
    }
    
    private func swapCameraInput(useFrontCamera: Bool) {
        if(isSessionActive) {
            session.beginConfiguration()
            session.removeInput(session.inputs.first! as! AVCaptureInput);
            var captureDevice: AVCaptureDevice? = cameraWithPosition(useFrontCamera ? AVCaptureDevicePosition.Front : AVCaptureDevicePosition.Back)
            var err = NSErrorPointer()
            var newVideoInput = AVCaptureDeviceInput(device: captureDevice, error: err)
            
            if(err != nil) {
                println("Error: \(err.debugDescription)")
            }
            session?.addInput(newVideoInput)
            session.commitConfiguration()
            isFrontCameraActive = useFrontCamera
            delegate?.cameraDidSwap(useFrontCamera)
        }
    }
    
    func toggleFlash(flashOn: Bool) {
        if(!isFrontCameraActive && isSessionActive) {
            session.beginConfiguration()
            var captureDevice: AVCaptureDevice? = cameraWithPosition(AVCaptureDevicePosition.Back)
            captureDevice?.lockForConfiguration(nil)
            captureDevice?.torchMode = flashOn ? AVCaptureTorchMode.On : AVCaptureTorchMode.Off
            captureDevice?.unlockForConfiguration()
            session.commitConfiguration()
            self.isFlashActive = flashOn
            delegate?.flashDidToggle(flashOn)
        }
    }
    
    // MARK - Capture Management
    
    func startCapture() {
        
        println("Starting Capture!")
        assetURL = NSURL(fileURLWithPath: "\(NSTemporaryDirectory())Cloak-\(String(NSDate().hash)).mp4")!
        var err = NSErrorPointer()
        assetWriter = AVAssetWriter(URL: assetURL, fileType: AVFileTypeQuickTimeMovie, error: NSErrorPointer())
        if(err != nil) {
            println("Error: \(err.debugDescription)")
        }
        
        assetInput = AVAssetWriterInput(mediaType: AVMediaTypeVideo, outputSettings: self.VIDEO_OUTPUT_SETTINGS)
        assetInput.expectsMediaDataInRealTime = true
        assetWriter.shouldOptimizeForNetworkUse = true
        
        assetWriter.addInput(assetInput)
        assetWriter.startWriting()
        
        var videoOutput:AVCaptureVideoDataOutput = session.outputs.first as! AVCaptureVideoDataOutput
        for connection in videoOutput.connections {
            if let conn = connection as? AVCaptureConnection {
                if conn.supportsVideoOrientation {
                    conn.videoOrientation = AVCaptureVideoOrientation.Portrait
                }
            }
        }
        
        isCapturing = true
        delegate?.captureDidStart()
    }
    
    private func stopCapture() {
        assetInput.markAsFinished()
        assetWriter.finishWritingWithCompletionHandler { () -> Void in
            println("Done!")
            println("Ending Capture!")
            self.delegate?.onProgressUpdate(1.0)
            self.delegate?.captureDidEnd(self.assetWriter.outputURL!)
            
            //            ALAssetsLibrary().writeVideoAtPathToSavedPhotosAlbum(self.assetURL, completionBlock: { (path:NSURL!, error:NSError!) -> Void in
            //                println("Saved to Library!")
            //                // Jump to iOS Photo
            //            })
        }
    }
    
    // MARK - AVCaptureVideoDataOutputSampleBufferDelegate
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        dispatch_async(captureQueue, { ()->() in
            if(self.isCapturing) {
                if(self.frameIndex >= self.FRAME_COUNT) {
                    self.frameIndex = self.START_INDEX
                    self.isCapturing = false
                    self.stopCapture()
                    return
                }
                
                if(self.frameIndex % self.FRAME_INTERVAL == 0 && self.frameIndex > 0) {
                    println("Capturing Frame...")
                    var currentIndex:Int = self.frameIndex / self.FRAME_INTERVAL
                    
                    // TODO: Build Queue for Postponed Frames
                    if(self.assetInput.readyForMoreMediaData) {
                        var sampleTimingInfo: CMSampleTimingInfo = CMSampleTimingInfo(
                            duration: CMTimeMake(self.OUTPUT_FRAMESIZE, self.OUTPUT_TIMESCALE),
                            presentationTimeStamp: CMTimeMake(Int64(Int64(currentIndex) * self.OUTPUT_FRAMESIZE), self.OUTPUT_TIMESCALE),
                            decodeTimeStamp: kCMTimeInvalid
                        )
                        var newSampleBuffer:CMSampleBufferRef = self.adjustTimestamp(sampleBuffer, newTiming: sampleTimingInfo)
                        self.assetWriter.startSessionAtSourceTime(CMSampleBufferGetOutputPresentationTimeStamp(newSampleBuffer))
                        self.assetInput.appendSampleBuffer(newSampleBuffer)
                    }
                }
                self.delegate?.onProgressUpdate(Float(self.frameIndex) / Float(self.FRAME_COUNT))
                self.frameIndex++
            }
        })
    }
    
    func adjustTimestamp(sample: CMSampleBufferRef, newTiming: CMSampleTimingInfo) -> CMSampleBufferRef {
        var count: CMItemCount = 0
        CMSampleBufferGetSampleTimingInfoArray(sample, 0, nil, &count);
        var info = [CMSampleTimingInfo](
            count: count,
            repeatedValue: CMSampleTimingInfo(duration: CMTimeMake(0, 0),
                presentationTimeStamp: CMTimeMake(0, 0),
                decodeTimeStamp: CMTimeMake(0, 0))
        )
        CMSampleBufferGetSampleTimingInfoArray(sample, count, &info, &count);
        
        for i in 0..<count {
            info[i] = newTiming
        }
        
        var out: Unmanaged<CMSampleBuffer>?
        CMSampleBufferCreateCopyWithNewTiming(nil, sample, count, &info, &out);
        return out!.takeRetainedValue()
    }
    
}

protocol CaptureManagerDelegate {
    func cameraDidSwap(frontCamera: Bool)
    func flashDidToggle(isFlashOn: Bool)
    func captureDidStart()
    func captureDidEnd(assetURL: NSURL)
    func onProgressUpdate(progress: Float)
}