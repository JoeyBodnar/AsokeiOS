//
//  ParentViewController.swift
//  DownvoteN00bs
//
//  Created by Stephen Bodnar on 05/04/2017.
//  Copyright © 2017 Stephen Bodnar. All rights reserved.
//

import Foundation
import UIKit

class ParentViewController: UIViewController {
    var scrollView: UIScrollView! //scrollView that the imageview will go inside(for zooming)
    var imageToCrop = UIImage() // the image passed in the init that will be cropped
    var imageView = UIImageView() // image view for the image
    var croppingRect = CGRect() // The rectangle/square that will be used to crop the picture to a new dimension
    var imageTotalHeight = CGFloat() // this is the total height of the picture inside the imageView that we see in screen
    var height = CGFloat() // the height of the cropping rect (=croppingRect.height)
    var imageToPass = UIImage() // the image to be passed back in the delegate that has been cropped
    var viewHasAppeared = false // tells whether or not the view has appeared on screen
    var imageHeightDifference = CGFloat() //(height of compressed image - height of center view), tells us how much extra vertical scroll needed
    
    var delegate: AsokeDelegate?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewHasAppeared = true
        if imageView.image != nil {
            imageToPass = crop(imageView.image!)
        }
    }
    
   
    
    func setupScrollView() {
        scrollView = UIScrollView(frame: view.frame)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        scrollView.backgroundColor = UIColor.clear
        view.addSubview(scrollView)
    }
    
    func setupPhoto() {
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        height = croppingRect.height
        if let image = imageToCrop.unrotatedImage() {
           
            let imageHeight = image.size.height
            let imageWidth = image.size.width
            // to see how much width has been compressed
            let ratio = imageWidth / self.view.frame.width
            
             //imageTotalHeight calculation
            imageTotalHeight  = imageHeight / ratio
            imageHeightDifference = imageTotalHeight - height
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width:screenWidth, height: screenHeight + imageHeightDifference))
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            self.scrollView.addSubview(imageView)
            scrollView.contentSize = imageView.frame.size
            
            // put the image in the middle of the scroll view
            scrollView.contentOffset.y = (imageHeightDifference / 2)
        }
    }
    
    // The function to actually crop an image
    // Lots of tedious math done here to calculate new rect to crop correctly
    func crop(_ imageToCrop: UIImage) -> UIImage {
        let viewWidth = croppingRect.width
        let scale = imageToCrop.size.width / imageView.frame.size.width
        
        let zoomscale = self.scrollView.zoomScale
        let xOffset = scrollView.contentOffset.x
        let yOffset = scrollView.contentOffset.y
        let CVRectYOrigin = croppingRect.origin.y
        if zoomscale == 1 {
            // get distance form top of screen to top of AVCRect
            // now, get the height that the image is currently from the top
            let topWhiteSpace = ((scrollView.frame.height - imageTotalHeight) / 2) - yOffset
            let visibleTopY = CVRectYOrigin - topWhiteSpace - (imageHeightDifference / 2)
            let newRect = CGRect(x: (croppingRect.origin.x * scale), y: (visibleTopY * scale), width: (croppingRect.width * scale), height: (height * scale))
            let imageRef:CGImage = imageToCrop.cgImage!.cropping(to: newRect)!
            let cropped:UIImage = UIImage(cgImage:imageRef)
            return cropped
        } else { // zoomed in
            let visibleImageHeight = imageTotalHeight * zoomscale
            let distance = (imageView.frame.height - (visibleImageHeight)) / 2 - yOffset
            let actualYOrigin = (CVRectYOrigin - distance) * scale
            let newRect = CGRect(x:  ((xOffset * scale) + (croppingRect.origin.x * scale)), y: actualYOrigin, width: (viewWidth * scale), height: (height * scale))
            let imageRef:CGImage = imageToCrop.cgImage!.cropping(to: newRect)!
            let cropped:UIImage = UIImage(cgImage:imageRef)
            return cropped
        }
    }
}

extension ParentViewController {
    func addCancelButton() {
        let button = UIButton(frame: CGRect(x: (20), y: 20, width: 80, height: 30))
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 21)
        button.setTitle("Cancel", for: UIControlState())
        button.addTarget(self, action: #selector(cancelPressed), for: UIControlEvents.touchUpInside)
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.sizeToFit()
        self.view.addSubview(button)
    }
    
    func cancelPressed() {
        self.delegate?.cancelButtonWasPressed()
    }
}



extension ParentViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if viewHasAppeared && imageView.image != nil {
            imageToPass = crop(imageView.image!)
        }
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if viewHasAppeared && imageView.image != nil {
            imageToPass = crop(imageView.image!)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewHasAppeared && imageView.image != nil {
            imageToPass = crop(imageView.image!)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}



