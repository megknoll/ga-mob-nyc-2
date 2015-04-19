//
//  SaveViewController.swift
//  FinalFaceDetection
//
//  Created by Meghan Knoll on 4/19/15.
//  Copyright (c) 2015 Meghan Knoll. All rights reserved.
//

import UIKit

class SaveViewController: UIViewController {
    var compositeImage : UIImage!
    
    @IBOutlet weak var polaroidMask: UIImageView!
    @IBOutlet weak var polaroidFrame: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if compositeImage != nil {
            var frameHeight = polaroidFrame.image?.size.height
            //compositeImage.size.height = frameHeight * 0.80
            polaroidMask.image = compositeImage
        }
    }


}
