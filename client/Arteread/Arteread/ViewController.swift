//
//  ViewController.swift
//  Arteread
//
//  Created by Damian Diaz on 11/6/19.
//  Copyright © 2019 Damian Diaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var AMOUNT = 185
    var GOAL = 300
    var progress = CGFloat(0)
    
    // layers
    var pulsatingLayer: CAShapeLayer!
    var shapeLayer = CAShapeLayer()
    var trackLayer = CAShapeLayer()
    
    // color palette
    let _lightGreyAlpha = UIColor(red:0.27, green:0.27, blue: 0.27,alpha: 0.37)
    let _darkGrey = UIColor(red:0.17, green:0.17, blue: 0.17,alpha: 1.0)
    let _mint = UIColor(red:0.25, green:0.89, blue: 0.62,alpha: 1.0)
    let _mintShadow = UIColor(red:0.32, green:0.43, blue: 0.38,alpha: 1.0)
    let _mintAlpha = UIColor(red:0.25, green:0.89, blue: 0.62,alpha: 0.37)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawBackground()
        drawHeadings()
        drawProgressCircle()
    
    }
    
    public func updateAmount(amount:Int){
        AMOUNT = amount
        updateProgress()
    }
    
    public func updateGoal(amount:Int){
        GOAL = amount
        updateProgress()
    }
    
    private func updateProgress(){
        progress = CGFloat(AMOUNT) / CGFloat(GOAL)
        
    }
    
    private func drawBackground(){
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = [_darkGrey.cgColor, UIColor.black.cgColor]
        layer.startPoint = CGPoint(x:0.5, y:0.0)
        layer.endPoint = CGPoint(x:0.5, y:1.0)
        view.layer.addSublayer(layer)
    }
    
    private func drawHeadings(){
       
    }
    
    private func label(text:String, textAlignment:NSTextAlignment, font:UIFont, color:UIColor) -> UILabel{
         let label = UILabel()
         label.text = text
        label.textAlignment = .center
         label.font = font
         label.textColor = color
         return label
     }
    
    private func createCircleShapeLayer(lineWidth: CGFloat, strokeColor: UIColor, fillColor: UIColor, shapeEnd:Bool) -> CAShapeLayer{
        let layer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: .zero, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
        layer.path = circularPath.cgPath
        layer.fillColor = fillColor.cgColor
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = lineWidth
        layer.position = view.center
        
        if(shapeEnd){
            layer.strokeEnd = 0
        }
        
        return layer
    }

    private func drawProgressCircle(){
        
        updateProgress()
               
        var progressLabel = label(text:"\(AMOUNT)", textAlignment:.center, font:UIFont.boldSystemFont(ofSize: 48), color:.white)
        view.addSubview(progressLabel)
        progressLabel.frame = CGRect(x:0,y:0,width: 100,height: 100)
        progressLabel.center = view.center
        
        let unitLabel = label(text:"mg",textAlignment:.center,font:UIFont.systemFont(ofSize: 24, weight: .light), color:.white)
        view.addSubview(unitLabel)
        unitLabel.frame = CGRect(x:0,y:0,width: 100,height: 100)
        unitLabel.center = progressLabel.center
        unitLabel.center.y += 30
               
        pulsatingLayer = createCircleShapeLayer(lineWidth: 30, strokeColor: _mint, fillColor: UIColor.clear, shapeEnd: false)
        view.layer.addSublayer(pulsatingLayer)
             
        trackLayer = createCircleShapeLayer(lineWidth: 40, strokeColor: _mintShadow, fillColor: UIColor.clear, shapeEnd: false)
        view.layer.addSublayer(trackLayer)
               
        shapeLayer = createCircleShapeLayer(lineWidth: 30, strokeColor: _mint, fillColor: UIColor.clear, shapeEnd: true)
        view.layer.addSublayer(shapeLayer)
        
        animateProgress()
        animatePulsating()
               
    }
    
    private func animatePulsating(){
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = 1.1
        animation.duration = 0.6
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        
        pulsatingLayer.add(animation, forKey: "pulsing")
    }
    
    private func animateProgress(){
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 5/6, 0.1, 2/6, 0.9)
        basicAnimation.fromValue = 0
        basicAnimation.toValue = progress
        basicAnimation.duration = 1 // in seconds
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "basic")
        
    }
}

