//
//  ViewController.swift
//  AsokeDemo
//
//  Created by Stephen Bodnar on 08/04/2017.
//  Copyright © 2017 Stephen Bodnar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.backgroundColor = UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func showCircleCropVC(sender: UIButton) {
        let image = UIImage(named: "me")!
        let circleVC = AsokeCircularVC(circleRadius: 158, withImageToCrop: image)
        circleVC.delegate = self
        self.present(circleVC, animated: true, completion: nil)
    }
    
    @IBAction func showRectangleCropVC(sender: UIButton) {
        let image = UIImage(named: "me")!
        let rect = CGRect(x: 10, y: 150, width: 300, height: 240)
        let rectVC = AsokeRectangularVC(croppingRect: rect, withImageToCrop: image)
        rectVC.delegate = self
        self.present(rectVC, animated: true, completion: nil)
    }

}

extension ViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            // If you are using Asoke with UIImagePickerController, here is where you
            // will present either AsokeCircularVC or AsokeRectangularVC, passing in pickedImage as the image to crop
        }
    }
}

extension ViewController: AsokeDelegate {
    func cancelButtonWasPressed() {
        print("cancel was pressed")
        self.dismiss(animated: true, completion: nil)
    }
    
    func didFailWithError(_ error: NSError) {
        print("failed with error")
    }
    
    func didFinishCroppingImage(_ croppedImage: UIImage) {
        imageView.image = croppedImage
        self.dismiss(animated: true, completion: nil)
    }
}

