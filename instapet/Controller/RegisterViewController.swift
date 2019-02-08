//
//  RegisterViewController.swift
//  instapet
//
//  Created by Bar Molot on 21/01/2019.
//  Copyright © 2019 Bar Molot. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var phoneInput: UITextField!
    
    var gradientLayer: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createGradient()
    }
    
    @IBAction func createTapped(_ sender: Any) {
        guard let email = emailInput.text else { return }
        guard let password = passwordInput.text else { return }
        guard let username = usernameInput.text else { return }
        guard let phone = phoneInput.text else { return }
        
        AuthenticationDAO.createUser(email: email, password: password) { (user, err) in
            if (err != nil) {
                // Error creating account
                let alert = UIAlertController(title: "Error", message: err?.localizedDescription, preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                if let uid = AuthenticationDAO.getUserId() {
                    // success
                    let user = User(uid: uid, username: username, phonenum: phone)
                    UserDAO.createUserData(user: user)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabController")
                    self.tabBarController?.selectedIndex = 0
                    self.present(vc!, animated: true, completion: nil)
                } else {
                    print("Error")
                }
            }
        }
    }
    
    func createGradient() {
        let gradientLayer = GradientHandler.shared.get(top: 0xE55D87, bottom: 0x5FC3E4)
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
