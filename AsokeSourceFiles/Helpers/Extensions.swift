//
//  Extensions.swift
//  DownvoteN00bs
//
//  Created by Stephen Bodnar on 05/04/2017.
//  Copyright © 2017 Stephen Bodnar. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func circularImage(_ radius: CGFloat) -> UIImage {
        var imageView = UIImageView()
        if self.size.width > self.size.height {
            imageView.frame =  CGRect(x: 0, y: 0, width: self.size.width, height: self.size.width)
            imageView.image = self
            imageView.contentMode = .scaleAspectFit
            
        } else {
            imageView = UIImageView(image: self)
        }
        var layer: CALayer = CALayer()
        
        layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = radius
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return roundedImage!
    }
    
    
    // images coming from a user's phone may be roated incorrectly. This function rotates them to portrait orientation
    func unrotatedImage() -> UIImage? {
        UIGraphicsBeginImageContext(self.size)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
