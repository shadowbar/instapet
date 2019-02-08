//
//  PostDAO.swift
//  instapet
//
//  Created by Bar Molot on 02/02/2019.
//  Copyright © 2019 Bar Molot. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class PostDao {
    static let imageCache = NSCache<NSString, UIImage>()

    static func createPost(author: String, image: UIImage, description: String) {
        let postsRef = Database.database().reference().child("posts")
        guard let pid = postsRef.childByAutoId().key else { return }
        
        uploadPostImage(pid: pid, image: image) { url in
            if url != nil {
                let post = [
                    "author": author,
                    "image": url!,
                    "description": description,
                    "upload": Date().timeIntervalSince1970
                    ] as [String : Any]
                postsRef.child(pid).setValue(post)
            }
        }
    }
    
    static func getPosts(complition: @escaping (Post) -> Void) {
        let postsRef = Database.database().reference().child("posts")
        postsRef.queryOrdered(byChild: "upload").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? NSDictionary
            let pid = post?["pid"] as? String ?? ""
            let author = post?["author"] as? String ?? ""
            let image = post?["image"] as? String ?? ""
            let description = post?["description"] as? String ?? ""
            let upload = post?["upload"] as? TimeInterval ?? 0
            complition(Post(pid: pid, author: author, image: image, description: description, upload: upload))
        })
    }
    
    static func getUserPosts(complition: @escaping (Post) -> Void) {
        guard let uid = AuthenticationDAO.getUserId() else { return }
        let postsRef = Database.database().reference().child("posts")
        postsRef.queryOrdered(byChild: "author").queryEqual(toValue: uid).observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? NSDictionary
            let pid = post?["pid"] as? String ?? ""
            let author = post?["author"] as? String ?? ""
            let image = post?["image"] as? String ?? ""
            let description = post?["description"] as? String ?? ""
            let upload = post?["upload"] as? TimeInterval ?? 0
            complition(Post(pid: pid, author: author, image: image, description: description, upload: upload))
        })
    }
    
    private static func uploadPostImage(pid:String, image:UIImage, complition: @escaping (String?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let storageRef = Storage.storage().reference().child("post/\(pid)")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"

        storageRef.putData(imageData, metadata: metaData) { (metadata, error) in
            // You can also access to download URL after upload.
            storageRef.downloadURL { (url, error) in
                if let downloadURL = url {
                    complition(downloadURL.absoluteString)
                } else {
                    complition(nil)
                }
            }
        }
    }
}
