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
    @IBOutlet weak var ErrorTextField: UILabel!
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
                        
                        self.ErrorTextField.text = "There was an error signing you in, make sure you have the correct password"
                        
                    } else {
                        print("Created user Succesfully")
                        
                        FIRDatabase.database().reference().child("user").child(user!.uid).child("email").setValue(user!.email!) // finds the database reference - creates an array called user, then passes a child called email with the value named email
                        
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

