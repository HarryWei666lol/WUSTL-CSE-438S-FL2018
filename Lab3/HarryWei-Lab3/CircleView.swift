//
//  circleView.swift
//  HarryWei-Lab3
//
//  Created by Harry Wei on 10/2/18.
//  Copyright © 2018 Harry Wei. All rights reserved.
//
import UIKit

class CircleView: UIView {
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var theCircle: Circle?{
        didSet{
            setNeedsDisplay()
        }
    }
    
    var circles: [Circle] = []{
        didSet{
            setNeedsDisplay()
        }
    }
    
    func drawCircle(_ circle: Circle){
        UIColor.green.setFill()
        let path = UIBezierPath()
        
        path.addArc(withCenter: circle.center, radius: circle.radius, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: true)
        path.fill()
        UIColor.black.setStroke()
        path.stroke()
        
    }
    
    override func draw(_ rect: CGRect) {
        
        for circle in circles{
            drawCircle(circle)
        }
        if(theCircle != nil){
            drawCircle(theCircle!)
        }
    }
    
    
}
