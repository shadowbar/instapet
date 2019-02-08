//
//  UploadViewController.swift
//  instapet
//
//  Created by Bar Molot on 02/02/2019.
//  Copyright © 2019 Bar Molot. All rights reserved.
//

import UIKit
import Photos
import NVActivityIndicatorView

class UploadViewController: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        self.uploadImageView.isUserInteractionEnabled = true
        self.uploadImageView.addGestureRecognizer(tapGestureRecognizer)
        
        self.descriptionTextView.delegate = self
        
        self.resetUpload()
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        self.startAnimating(CGSize(width: 20, height: 20), message: "Choose Image", type: NVActivityIndicatorType.circleStrokeSpin)
        CameraHandler.shared.showActionSheet(vc: self)
        CameraHandler.shared.imagePickedBlock = { (image) in
            if image != nil {
                self.uploadImageView.image = image
            }
            self.stopAnimating()
        }
    }
    
    @IBAction func uploadTap(_ sender: Any) {
        guard let uid = AuthenticationDAO.getUserId() else { return }
        guard let image = self.uploadImageView.image else { return }
        if image != UIImage(named: "placeholder") && self.descriptionTextView.text != "" &&
            self.descriptionTextView.text != "Please insert description about the pet." {
            PostDao.createPost(author: uid, image: image, description: self.descriptionTextView.text)
            self.tabBarController?.selectedIndex = 0
            self.resetUpload()
        } else {
            let alert = UIAlertController(title: "Error", message: "Please choose image and text", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func logoutTap(_ sender: Any) {
        AuthenticationDAO.signout()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        self.present(vc!, animated: true, completion: nil)
    }

    func resetUpload() {
        self.uploadImageView.image = UIImage(named: "placeholder")
        self.descriptionTextView.text = "Please insert description about the pet."
        self.descriptionTextView.textColor = UIColor.lightGray
    }
}

extension UploadViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Please insert description about the pet."
            textView.textColor = UIColor.lightGray
        }
    }
}
