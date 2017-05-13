//
//  RectangularOverlayView.swift
//  DownvoteN00bs
//
//  Created by Stephen Bodnar on 04/04/2017.
//  Copyright © 2017 Stephen Bodnar. All rights reserved.
//

import Foundation
import UIKit

class RectangularOverlayView: UIView {
    
    var croppingRect = CGRect()
    
    init(frame: CGRect, withCroppingRect croppingRect: CGRect) {
        super.init(frame: frame)
        self.croppingRect = croppingRect
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        alpha = 0.7
        isUserInteractionEnabled = false
        backgroundColor = UIColor.black
        clipsToBounds = true
    }
    
    override func draw(_ rect: CGRect) {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: croppingRect.origin.x, y: croppingRect.origin.y))
        path.addLine(to: CGPoint(x: croppingRect.minX, y: croppingRect.maxY))
        path.addLine(to: CGPoint(x: croppingRect.maxX, y: croppingRect.maxY))
        path.addLine(to: CGPoint(x: croppingRect.maxX, y: croppingRect.minY))
        
        // whiteOutlinePath is for the white outline we want to show on screen
        // we do this before the path.addRect so that it does not color the above path variable in white as well
        let whiteOutlinePath = UIBezierPath(cgPath: path)
        whiteOutlinePath.close()
        UIColor.white.setStroke()
        whiteOutlinePath.lineWidth = 3
        whiteOutlinePath.stroke()
        
        path.addRect((superview?.frame)!)
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        maskLayer.fillRule = kCAFillRuleEvenOdd
        
        // set the view's layer.mask property to our mask layer that we created, leaving the empty transparent hole
        layer.mask = maskLayer
        
    }
    
}

