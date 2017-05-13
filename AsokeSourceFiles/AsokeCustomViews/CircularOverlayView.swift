//
//  CircularOverlayView.swift
//  DownvoteN00bs
//
//  Created by Stephen Bodnar on 04/04/2017.
//  Copyright © 2017 Stephen Bodnar. All rights reserved.
//

import Foundation
import UIKit

class CircularOverlayView: UIView {
    var radius = CGFloat()
    
    init(frame: CGRect, withRadius radius: CGFloat) {
        super.init(frame: frame)
        self.radius = radius
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        alpha = 0.7
        isUserInteractionEnabled = false
        backgroundColor = UIColor.black
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func draw(_ rect: CGRect) {
        let path = CGMutablePath()
        if let theSuperView = superview {
            let xOffset:CGFloat = (theSuperView.frame.width) / 2
            let yOffset:CGFloat = (theSuperView.frame.height) / 2
            path.addArc(center: CGPoint(x: xOffset, y: yOffset), radius: radius, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
            
            let rectangularWhitePath = UIBezierPath(cgPath: path)
            UIColor.white.setStroke()
            rectangularWhitePath.lineWidth = 3
            rectangularWhitePath.stroke()
            
            path.addRect(CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
            
            
            
            let maskLayer = CAShapeLayer()
            maskLayer.backgroundColor = UIColor.black.cgColor
            maskLayer.path = path;
            maskLayer.fillRule = kCAFillRuleEvenOdd
            
            layer.mask = maskLayer
        }
    }
    
    // given a certain radius, we need to get a sqaure rect out of that
    // that square is what we will first crop the image to, and then
    // round it's corners via corner radius property to give a square image
    func croppingRectFromRadius() -> CGRect {
        let width = radius * 2
        let height = width
        let xOrigin = (frame.width / 2) - radius
        let yOrigin = (frame.height / 2) - radius
        
        let rect = CGRect(x: xOrigin, y: yOrigin, width: width, height: height)
        
        return rect
    }
    
    
    
}
