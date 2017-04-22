//
//  SelectUserViewController.swift
//  SnapChat
//
//  Created by callum brennan on 17/04/2017.
//  Copyright © 2017 callum brennan Mementcode. All rights reserved.
//

import UIKit
import Firebase


class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    
    var imageURL = ""
    var descrip = ""
    var uuid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        FIRDatabase.database().reference().child("user").observe(FIRDataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            let user = User()
            //user.email = snapshot.value(forKey: "email") as! String
            user.email = (snapshot.value as! NSDictionary)["email"] as! String // HOW TO RETRIVE USERS FROM FIREBASE
            user.uid = snapshot.key // HOW TO RETRIEVE UID's FROM FIREBASE
            
            self.users.append(user)
            
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        let snap = ["from" : user.email, "desciption" : descrip, "imageURL" : imageURL]
        
        FIRDatabase.database().reference().child("user").child(user.uid).child("snaps").childByAutoId().setValue(snap) // snap - relates to "let" above
        
        navigationController!.popToRootViewController(animated: true)
        
    }

}
