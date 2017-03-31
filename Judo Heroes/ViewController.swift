//
//  ViewController.swift
//  Judo Heroes
//
//  Created by Boris Rudas on 31/03/2017.
//  Copyright © 2017 Boris Rudas. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()?.addStateDidChangeListener() {(auth, user) in
            
            if auth.currentUser == nil {
                print("No user")
                self.performSegue(withIdentifier: "logIn", sender: ViewController.self)
            }
            else{
                print("We have a user: \(String(describing: auth.currentUser))")
            }
        }
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

