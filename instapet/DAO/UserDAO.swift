//
//  UserDAO.swift
//  instapet
//
//  Created by Bar Molot on 02/02/2019.
//  Copyright © 2019 Bar Molot. All rights reserved.
//

import Foundation
import Firebase

class UserDAO {
    static func createUserData(user: User) {
        let userRef = Database.database().reference().child("users").child(user.uid)
        let object = [
            "username": user.username,
            "phonenum": user.phonenum
        ]
        userRef.setValue(object)
    }
    
    static func getUser(uid: String, complition: @escaping (User?) -> Void){
        let ref = Database.database().reference()
        
        ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            let phonenum = value?["phonenum"] as? String ?? ""
            let user = User(uid: uid, username: username, phonenum: phonenum)
            complition(user)
        })
    }
}
