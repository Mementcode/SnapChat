//
//  ViewSnapViewController.swift
//  SnapChat
//
//  Created by callum brennan on 17/04/2017.
//  Copyright © 2017 callum brennan Mementcode. All rights reserved.
//

import UIKit
import SDWebImage

class ViewSnapViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var lable: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        lable.text = snap.descrip
    
        
        imageView.sd_setImage(with: URL(string: snap.imageURL))

        
        // Do any additional setup after loading the view.
    }

   

}
