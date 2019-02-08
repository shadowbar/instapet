//
//  FeedTableViewController.swift
//  instapet
//
//  Created by Bar Molot on 02/02/2019.
//  Copyright © 2019 Bar Molot. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class FeedTableViewController: UITableViewController, NVActivityIndicatorViewable {
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startAnimating(CGSize(width: 20, height: 20), message: "Loading", type: NVActivityIndicatorType.circleStrokeSpin)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.initPosts()
    }
    
    func initPosts() {
        PostDao.getPosts { post in
            self.posts.insert(post, at: 0)
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.automatic)
            if self.isAnimating {
                self.stopAnimating()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostViewCell") as! PostViewCell
        cell.setPost(post: post)
        return cell
    }
    
    @IBAction func logoutTap(_ sender: Any) {
        AuthenticationDAO.signout()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        self.present(vc!, animated: true, completion: nil)
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
