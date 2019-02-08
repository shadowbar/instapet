//
//  PostViewCell.swift
//  instapet
//
//  Created by Bar Molot on 02/02/2019.
//  Copyright © 2019 Bar Molot. All rights reserved.
//

import UIKit
import SDWebImage

class FeedViewCell: UITableViewCell {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setPost(post: Post) {
        UserDAO.getUser(uid: post.author) { (user) in
            self.authorLabel.text = user.username + " - " + user.phonenum
            self.descriptionLabel.text = post.description
            if let cachedImage = PostDao.imageCache.object(forKey: post.image as NSString) {
                self.postImageView.image = cachedImage
            } else {
                self.postImageView.sd_setImage(with: URL(string: post.image), completed: { (image, error, cacheType, url) in
                    if image != nil {
                        PostDao.imageCache.setObject(image!, forKey: post.image as NSString)
                    } else if error != nil {
                        print(error!)
                    }
                })
            }
        }
    }
}
