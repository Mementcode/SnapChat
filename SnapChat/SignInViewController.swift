//
//  SignInViewController.swift
//  SnapChat
//
//  Created by callum brennan on 16/04/2017.
//  Copyright © 2017 callum brennan Mementcode. All rights reserved.
//

import UIKit
import Firebase


class SignInViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            
            print("we tried to sign in")
            
            if error != nil {
                print("we have an error:\(String(describing: error))")
                
                
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("we tried to create a user")
                    if error != nil{
                        
                        print("we have an error:\(String(describing: error))")
                    } else {
                        print("Created user Succesfully")
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)

                    }
                })
            } else {
                print ("Sign in Successful")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
            
        })
        
    }
    
    
}

