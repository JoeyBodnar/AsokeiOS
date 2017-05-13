//
//  AsokeHelpers.swift
//  DownvoteN00bs
//
//  Created by Stephen Bodnar on 08/04/2017.
//  Copyright © 2017 Stephen Bodnar. All rights reserved.
//

import Foundation
import UIKit

class AsokeHelpers {
    
    class func radiusIsValid(_ radius: CGFloat, inView view: UIView) -> Bool {
        let viewWidth = view.frame.width
        let validRadius = ((viewWidth / 2) - 1.5)
        if radius < validRadius {
            return true
        }
        return false
    }
    
    class func croppingRectIsValid(_ croppingRect: CGRect, inView view: UIView) -> Bool {
        let croppingRectOrigin = croppingRect.origin.x
        let viewWidth = view.frame.width
        let croppingRectWidth = croppingRect.width
        let viewHeight = view.frame.height
        let croppingRectHeight = croppingRect.height
        if croppingRectOrigin < 0 {
            return false
        }
        if croppingRectWidth > viewWidth {
            return false
        }
        if croppingRectHeight > viewHeight {
            return false
        }
        return true
    }
    
    
    
}
