//
//  TheDelegateHere.swift
//  DownvoteN00bs
//
//  Created by Stephen Bodnar on 04/04/2017.
//  Copyright © 2017 Stephen Bodnar. All rights reserved.
//

import Foundation
import UIKit

protocol AsokeDelegate {
    func didFinishCroppingImage(_ croppedImage: UIImage)
    func didFailWithError(_ error: NSError)
    func cancelButtonWasPressed()
}
