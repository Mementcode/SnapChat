//
//  PictureViewController.swift
//  SnapChat
//
//  Created by callum brennan on 17/04/2017.
//  Copyright © 2017 callum brennan Mementcode. All rights reserved.
//

import UIKit
import Firebase // INCLUDE ME!!!

// ALL 3 MUST BE INCLUDED
class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
  
    @IBOutlet weak var nextButton: UIButton!

    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
     var imagePicker = UIImagePickerController()
    
    var uuid = NSUUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()

       imagePicker.delegate = self  // INCLUDE ME!

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageView.image = image
        
        imageView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func CameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .savedPhotosAlbum // recives images from photo album
        imagePicker.allowsEditing = false // doesnt allow editing in app
        
      present(imagePicker, animated: true, completion: nil)
        
        
    }
  
    @IBAction func nextTapped(_ sender: Any) {
        
        nextButton.isEnabled = false // greys out button after it is tapped
        
        let imagesFolder = FIRStorage.storage().reference().child("image") // looks to the correct folder in firebase, storage, and then opens up folder "image"
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)! // converts the image to a JPEG with a compresion of 0.1 to speed up the app, and assins to imageData
        
        
        
        
        // uploads imageData to the folder "image" on fire base and returns any errors, if there are no errors then the segue is moved to the "selectUserSegue"
        // adds the NSUUID name with a .jpg at the end
        
        imagesFolder.child("\(String(describing: uuid)).jpg").put(imageData, metadata: nil, completion: {( metadata, error) in
            print("We tried to Upload")
            
            if error != nil {
                
                print ("we had an error:\(String(describing: error))")
            } else {
                
                print(metadata?.downloadURLs! as Any)
                self.performSegue(withIdentifier: "selectUserSegue", sender: metadata!.downloadURL()!.absoluteString)
            }
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let nextVC = segue.destination as! SelectUserViewController
        
        nextVC.imageURL = sender as! String
        nextVC.descrip = messageTextField.text!
        nextVC.uuid = uuid
 
    }
}
