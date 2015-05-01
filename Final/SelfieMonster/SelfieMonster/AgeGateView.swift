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
    var entryLabel : UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red:0.459, green:0.522, blue:0.620, alpha: 0.5)
        
    }

}
