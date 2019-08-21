//
//  ViewController.swift
//  HarryWei-Lab3
//
//  Created by Harry Wei on 9/29/18.
//  Copyright © 2018 Harry Wei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var drawingCanvasView: UIView!
    @IBOutlet weak var changeColor: UIStackView!
    var currLine : LineView?
    var currThickness: CGFloat!
    var currPenColor : UIColor!
    var currAlpha:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currThickness = 15
        currPenColor = UIColor.black
        currAlpha = 0.5

    }

    @IBAction func redButton(_ sender: Any) {
        currPenColor = UIColor.red
    }
    
    @IBAction func orangeButton(_ sender: Any) {
        currPenColor = UIColor.orange
    }
    
    @IBAction func yellowButton(_ sender: Any) {
        currPenColor = UIColor.yellow
    }
    
    @IBAction func blueButton(_ sender: Any) {
        currPenColor = UIColor.blue
    }
    
    @IBAction func pinkButton(_ sender: Any) {
        currPenColor = UIColor.purple
    }
    
    @IBAction func blackButton(_ sender: Any) {
        currPenColor = UIColor.black
    }
    
    @IBAction func greenButton(_ sender: Any) {
        currPenColor = UIColor.green
    }
    
    @IBAction func changeAlpha(_ sender: UISlider) {
        currAlpha = CGFloat(sender.value )
    }
    
    
    @IBAction func changeBackground(_ sender: Any) {
        drawingCanvasView.backgroundColor = UIColor(red: 181/255, green: 99/255, blue: 118/255, alpha: 1.0)
    }
    
    @IBAction func eraser(_ sender: Any) {
         currPenColor = UIColor.white
        currAlpha = 1
    }
    
    @IBAction func catImageButton(_ sender: Any) {
        let imageView = UIImageView(image: UIImage(named: "Cat"))
        let XCor = CGFloat(drand48()) * drawingCanvasView.frame.width
        let YCor = CGFloat(drand48()) * drawingCanvasView.frame.height
        imageView.frame = CGRect(x: XCor, y: YCor, width: 25 + 3 * currThickness, height: 25 + 3 * currThickness)
        drawingCanvasView.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        guard let touchPoint = touches.first?.location(in: drawingCanvasView)else{
            return
        }
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        currLine = LineView(frame: frame)
        currLine?.line = Line(points: [touchPoint], thickness: currThickness, color:currPenColor, alpha: currAlpha)
        drawingCanvasView.addSubview(currLine!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?){
        if (touches.first == nil) {
            return
        }
        for touch in touches{
            currLine?.line?.points.append(touch.location(in: drawingCanvasView))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?){
        guard let touchPoint = touches.first?.location(in:drawingCanvasView)
            else{
            return
        }
        currLine?.line?.points.append(touchPoint)
        //print("line number + \(currLine!.lineArray.count)")
    }

    @IBAction func changeLineThickness(_ sender: UISlider) {
        currThickness = CGFloat(sender.value * 30)
    }
    
    @IBAction func clear(_ sender: Any) {
        for v in drawingCanvasView.subviews{
            v.removeFromSuperview()
        }
    }
    
    @IBAction func undo(_ sender: UIButton) {
        if(drawingCanvasView.subviews.last != nil){
          drawingCanvasView.subviews.last!.removeFromSuperview()
        }
    }
}

