//
//  ProfileViewCell.swift
//  instapet
//
//  Created by Bar Molot on 08/02/2019.
//  Copyright © 2019 colman. All rights reserved.
//

import UIKit

class ProfileViewCell: UICollectionViewCell {
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    func setPost(post: Post) {
        self.descriptionLabel.text = post.description
        if let cachedImage = PostDao.imageCache.object(forKey: post.image as NSString) {
            self.postImage.image = cachedImage
        } else {
            self.postImage.sd_setImage(with: URL(string: post.image), completed: { (image, error, cacheType, url) in
                if image != nil {
                    PostDao.imageCache.setObject(image!, forKey: post.image as NSString)
                } else if error != nil {
                    print(error!)
                }
            })
        }
    }
}
