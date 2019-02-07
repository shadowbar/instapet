//
//  User.swift
//  instapet
//
//  Created by Bar Molot on 02/02/2019.
//  Copyright © 2019 Bar Molot. All rights reserved.
//

import Foundation

class User {
    var uid: String
    var username: String
    var phonenum: String
    
    init(uid: String, username: String, phonenum: String) {
        self.uid = uid
        self.username = username
        self.phonenum = phonenum
    }
}
