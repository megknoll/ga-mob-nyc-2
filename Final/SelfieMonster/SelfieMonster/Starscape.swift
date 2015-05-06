//
//  Starscape.swift
//  SelfieMonster
//
//  Created by Meghan Knoll on 5/2/15.
//  Copyright (c) 2015 Meghan Knoll. All rights reserved.
//

import UIKit

class Starscape: UIView {
    
    var starScape = [StarView]()
    var displayLink : CADisplayLink!
    var time : CFTimeInterval = 0
    var reverse = false
    
    required init(coder aDecoder: NSCoder) {super.init(coder: aDecoder)}
    
    required override init(frame: CGRect) {
        super.init(frame:frame)
        initStarArray()
        //displayLink  = CADisplayLink(target: self, selector: "reDraw:")
        //displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        
    }
    
    func reDraw(link : CADisplayLink)->(){
        time += link.duration
        if time < 1.0 {
            for star in starScape {
                if reverse {
                    star.drawStar(star.getRadius() + CGFloat(time), sides: star.getSides())
                } else {
                    star.drawStar(star.getRadius() - CGFloat(time), sides: star.getSides())
                }
            }
        } else {
            time = 0
            reverse = reverse ? false : true
        }
    }
    
    func initStarArray() {
        var starView = StarView(frame: CGRect(x:60,y:80,width:20,height:20))
        starView.drawStar(12,sides: 10)
        self.addSubview(starView)
        
        var starView1 = StarView(frame: CGRect(x:320,y:60,width:20,height:20))
        starView1.drawStar(7,sides: 8)
        self.addSubview(starView1)
        
        var starView2 = StarView(frame: CGRect(x:170,y:135,width:20,height:20))
        starView2.drawStar(7,sides: 5)
        self.addSubview(starView2)
        
        var starView3 = StarView(frame: CGRect(x:20,y:260,width:20,height:20))
        starView3.drawStar(10,sides: 8)
        self.addSubview(starView3)
        
        var starView4 = StarView(frame: CGRect(x:150,y:250,width:20,height:20))
        starView4.drawStar(12,sides: 5)
        self.addSubview(starView4)
        
        var starView5 = StarView(frame: CGRect(x:360,y:300,width:20,height:20))
        starView5.drawStar(10,sides: 8)
        self.addSubview(starView5)
        
        var starView6 = StarView(frame: CGRect(x:120,y:445,width:20,height:20))
        starView6.drawStar(7,sides: 10)
        self.addSubview(starView6)
        
        var starView7 = StarView(frame: CGRect(x:320,y:500,width:20,height:20))
        starView7.drawStar(10,sides: 8)
        self.addSubview(starView7)
        
        var starView8 = StarView(frame: CGRect(x:50,y:540,width:20,height:20))
        starView8.drawStar(7,sides: 5)
        self.addSubview(starView8)
        
        starScape = [starView,starView1,starView2,starView3,starView4,starView5,starView6,starView7,starView8]
        
    }
    
    deinit {
        displayLink.invalidate()
    }

    

}
