//
//  ViewController.swift
//  instapet
//
//  Created by Bar Molot on 21/01/2019.
//  Copyright © 2019 Bar Molot. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if AuthenticationDAO.getUserId() != nil {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabController")
            self.tabBarController?.selectedIndex = 0
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    @IBAction func signinTapped(_ sender: Any) {
        guard emailInput.text != nil && passwordInput.text != nil else {
            return
        }
        
        let email = emailInput.text!
        let password = passwordInput.text!
        
        AuthenticationDAO.signin(email: email, password: password, complition: { (user, error) in
            if (error == nil) {
                // success
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabController")
                self.tabBarController?.selectedIndex = 0
                self.present(vc!, animated: true, completion: nil)
            } else {
                // error logging in user
                let alert = UIAlertController(title: "Error", message: "Incorrect email or password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
}
