//
//  PostViewCell.swift
//  instapet
//
//  Created by Bar Molot on 02/02/2019.
//  Copyright © 2019 Bar Molot. All rights reserved.
//

import UIKit
import SDWebImage

class PostViewCell: UITableViewCell {
    
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
            self.authorLabel.text = user?.username
            self.descriptionLabel.text = post.description
            let imageView: UIImageView = self.postImageView
            let placeholderImage = UIImage(named: "placeholder.jpg")
            imageView.sd_setImage(with: URL(string: post.image), placeholderImage: placeholderImage)
        }
    }
}
