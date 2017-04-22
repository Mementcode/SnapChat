//
//  ViewSnapViewController.swift
//  SnapChat
//
//  Created by callum brennan on 17/04/2017.
//  Copyright © 2017 callum brennan Mementcode. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class ViewSnapViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var lable: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lable.text = snap.descrip
    
        
        imageView.sd_setImage(with: URL(string: snap.imageURL))

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        FIRDatabase.database().reference().child("user").child(FIRAuth.auth()!.currentUser!.uid).child("snaps").child(snap.key).removeValue()
        
        FIRStorage.storage().reference().child("image").child("\(String(describing: snap.uuid)).jpg").delete { (error) in
            print("We deleted the pic")
        }
    }
    


}
