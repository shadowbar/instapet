//
//  Post.swift
//  instapet
//
//  Created by Bar Molot on 02/02/2019.
//  Copyright © 2019 Bar Molot. All rights reserved.
//

import Foundation
import UIKit

class Post {
    var pid: String
    var author: String
    var image: String
    var description: String
    var upload: TimeInterval
    
    init(pid: String, author: String, image: String, description: String, upload: TimeInterval) {
        self.pid = pid
        self.author = author
        self.image = image
        self.description = description
        self.upload = upload
    }
}
