# Asoke
View controller for cropping profile pictures into rectangles, squares, and circles

Asoke is a dangerously simple way to add a view controller to your iOS Swift app that acts to crop photos to either a circle or a sqaure/rectangle. You can change the circle radius or the rect cropping area.

<div style="float:left"><img src="http://i.imgur.com/AOAhYzj.png" alt="Smiley face" height="500" width="229"></div>
<div style="float:left"><img src="http://i.imgur.com/d5xT5yr.png" alt="Smiley face" height="500" width="229"></div>

# Documentation
 
<h3>Integration into your project:</h3>

 1. Download the source files. Drag and drop them into your project. None of that Cocoapods BS. They are currently Swift 3.1   and Xcode 8.2 compatible. <br/>
 2. See number 1.

<h3>Presenting the view controller:</h3>
The view controller is simple to present. The following is an example for presenting the rectangualar crop VC:
      
        // You will need to init with an image and a cropping rect
        guard let image = UIImage(named: "yourImage") else { return }
        let rect = CGRect(x: 10, y: 150, width: 300, height: 240)
        let rectVC = AsokeRectangularVC(croppingRect: rect, withImageToCrop: image)
        
        // set the delegate and present.
        rectVC.delegate = self
        self.present(rectVC, animated: true, completion: nil)
        
And the following is an example for presenting the circular crop VC:

        // Need to init with an image and a radius
        guard let image = UIImage(named: "me") else { return }
        let circleVC = AsokeCircularVC(circleRadius: 158, withImageToCrop: image)
        circleVC.delegate = self
        self.present(circleVC, animated: true, completion: nil)
        
A few things to note:
    <ol>
    <li><h5>For the rectVC (the view controller that crops to a rectangle/square), the origin of your cropping rect may not: 1) be less than 0, and 2) the width of the cropping rect may not exceed the width of the viewcontroller's view property.</h5></li>
    <li><h5>For the circular view controller option, the radius may not exceed ((viewController.view.width / 2) - (1.5)). For example, on an iPhone 5, the view controller width property is 320, so the radius for your cropping circle may not exceed 158.5</h5></li>
    </ol>
        
        
<h3>Delegate callbacks</h3>

There are callbacks to your initial view controller for when certain actions occur: pressing the cancel button, the save button, or when an error occurs. You must implement all 3 to properly conform to the delegate.

      extension ViewController: AsokeDelegate {
       func cancelButtonWasPressed() {
            // cancel here, dismiss the VC, etc. This is called when the cancel button is pressed
       }
    
       func didFailWithError(_ error: NSError) {
            // handle the error here
        }
    
        func didFinishCroppingImage(_ croppedImage: UIImage) {
            // do something here with your image
       }
    }
    
    
<h3>Integration with UIImagePickerController</h3>

Many people look for a more customizable verion of editor for UIImagePickerController. They have a set default cropping rect that may not be suitable for all apps. Actually, that's what inspired this library. Asoke integrates well with UIImagePickerController, allowing you to choose a different cropping rect/circle for the image you chose from UIImagePickerController. Here is an example:

       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // make sure there is an image before seguing
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
           // Need to init with an image and a radius
             let circleVC = AsokeCircularVC(circleRadius: 158, withImageToCrop: pickedImage)
             circleVC.delegate = self
             picker.show(circleVC, sender: self)
        }
    }



      



