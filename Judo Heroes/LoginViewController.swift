//
//  LoginViewController.swift
//  Judo Heroes
//
//  Created by Boris Rudas on 31/03/2017.
//  Copyright © 2017 Boris Rudas. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTexfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleRegister() {
        FIRAuth.auth()?.createUser(withEmail: emailTextfield.text!, password: passwordTexfield.text!, completion: { (user:FIRUser?, error) in
            if error != nil {
                print(error!)
                return
            }
            self.dismiss(animated: true, completion: nil)
        })
        
    }
    func handleLogin() {
        FIRAuth.auth()?.signIn(withEmail: emailTextfield.text!, password: passwordTexfield.text!) { (user, error) in
            if user == nil {
                self.handleRegister()
            }
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        
        handleLogin()
//        handleRegister()
        
    }
}
