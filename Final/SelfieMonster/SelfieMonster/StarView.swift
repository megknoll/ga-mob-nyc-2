//
//  StarView.swift
//  SelfieMonster
//
//  Created by Meghan Knoll on 5/1/15.
//  Copyright (c) 2015 Meghan Knoll. All rights reserved.
//

import UIKit

class StarView: UIView {

    var shapeLayer : CAShapeLayer!
    
    func drawStar(radius: CGFloat, sides: Int) {
        
        shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor(red:0.278, green:0.718, blue:0.635, alpha: 0.5).CGColor
        
        self.layer.addSublayer(shapeLayer)
        
        var path = drawStarBezier(0, y: 0, radius: radius, sides: sides,  pointyness: 2)
        
        shapeLayer.path = path.CGPath
    }

    func degree2radian(a:CGFloat)->CGFloat {
        let b = CGFloat(M_PI) * a/180
        return b
    }
    
    func polygonPointArray(sides:Int,x:CGFloat,y:CGFloat,radius:CGFloat,adjustment:CGFloat=0)->[CGPoint] {
        let angle = degree2radian(360/CGFloat(sides))
        let cx = x // x origin
        let cy = y // y origin
        let r  = radius // radius of circle
        var i = sides
        var points = [CGPoint]()
        while points.count <= sides {
            let xpo = cx - r * cos(angle * CGFloat(i)+degree2radian(adjustment))
            let ypo = cy - r * sin(angle * CGFloat(i)+degree2radian(adjustment))
            points.append(CGPoint(x: xpo, y: ypo))
            i--;
        }
        return points
    }
    
    
    func starPath(x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, pointyness:CGFloat) -> CGPathRef {
        let adjustment = 360/sides/2
        let path = CGPathCreateMutable()
        let points = polygonPointArray(sides,x: x,y: y,radius: radius)
        var cpg = points[0]
        let points2 = polygonPointArray(sides, x: x,y: y, radius: radius*pointyness, adjustment: CGFloat(adjustment))
        var i = 0
        CGPathMoveToPoint(path, nil, cpg.x, cpg.y)
        for p in points {
            CGPathAddLineToPoint(path, nil, points2[i].x, points2[i].y)
            CGPathAddLineToPoint(path, nil, p.x, p.y)
            i++
        }
        CGPathCloseSubpath(path)
        return path
    }
    
    func drawStarBezier(x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, pointyness:CGFloat)->UIBezierPath {
        let path = starPath(x, y:y, radius:radius, sides: sides,pointyness: pointyness)
        starPath(x, y: y, radius: radius, sides: sides, pointyness: pointyness)
        let bez = UIBezierPath(CGPath: path)
        return bez
    }

}
