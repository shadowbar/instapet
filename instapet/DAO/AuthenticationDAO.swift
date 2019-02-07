//
//  Authentication.swift
//  instapet
//
//  Created by Bar Molot on 21/01/2019.
//  Copyright © 2019 Bar Molot. All rights reserved.
//

import UIKit
import Firebase

class AuthenticationDAO {
    
    static func getUserId() -> String? {
        if (Auth.auth().currentUser == nil){
            return nil
        } else {
            return Auth.auth().currentUser?.uid
        }
    }
    
    static func signout() {
        do {
            try Auth.auth().signOut()
        } catch{
            print("ERROR SIGNING OUT USER!")
        }
    }
    
    static func signin(email: String, password:String, complition: @escaping (Any?,Any?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            complition(user, error)
        }
    }
    
    static func createUser(email: String, password: String, complition: @escaping (Any?,Error?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (user, err) in
            complition(user, err)
        }
    }
}
