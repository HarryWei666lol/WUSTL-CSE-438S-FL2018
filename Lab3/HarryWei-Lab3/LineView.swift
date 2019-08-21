//
//  LineView.swift
//  HarryWei-Lab3
//
//  Created by Harry Wei on 9/29/18.
//  Copyright © 2018 Harry Wei. All rights reserved.
//

import UIKit
import Foundation

class LineView: UIView {
    
    // from CircleView Example
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    // from CircleView Example
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // from CircleView Example
    var line:Line? {
        didSet {
            setNeedsDisplay()
        }
    }
    // put lines in an array
    var lineArray : [Line] = []{
        
        didSet{
            setNeedsDisplay()
        }
        
    }
    
    // draw line function
    func drawLine(_ singleLine : Line){
        
        singleLine.color.set()
        
        let path = createQuadPath(points: singleLine.points)
        
        path.lineWidth = singleLine.thickness
        path.stroke(with : .normal, alpha : (line?.alpha)!)
        
    }
    
    // general draw function
    override func draw(_ rect: CGRect) {
        
        for line in lineArray{
            drawLine(line)
        }
        
        if (line != nil){
            drawLine(line!)
        }
    }
    
    // self-implementation
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        // implement this function here
        return CGPoint(x:(first.x + second.x) / 2, y:(first.y + second.y) / 2)
    }
    
    
    // supplied by Lab3 instruction
    func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        
        let path = UIBezierPath()
        if points.count < 2 { return path }
        let firstPoint = points[0]
        let secondPoint = points[1]
        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
        path.move(to: firstPoint)
        path.addLine(to: firstMidpoint)
        for index in 1 ..< points.count-1 {
            let currentPoint = points[index]
            let nextPoint = points[index + 1]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
        }
        guard let lastLocation = points.last else { return path }
        path.addLine(to: lastLocation)
        path.lineCapStyle = .round
        return path
        
    }

}
