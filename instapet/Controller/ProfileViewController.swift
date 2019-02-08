//
//  ProfileCollectionViewController.swift
//  instapet
//
//  Created by Bar Molot on 08/02/2019.
//  Copyright © 2019 colman. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.initPosts()
    }
    
    func initPosts() {
        PostDao.getUserPosts { post in
            self.posts.insert(post, at: 0)
            self.collectionView!.insertItems(at: [IndexPath(item: 0, section: 0)])
        }
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let post = posts[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileViewCell", for: indexPath) as! ProfileViewCell
        cell.setPost(post: post)
        return cell
    }

    @IBAction func logoutTap(_ sender: Any) {
        AuthenticationDAO.signout()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        self.present(vc!, animated: true, completion: nil)
    }
}
