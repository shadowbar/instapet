//
//  UploadViewController.swift
//  instapet
//
//  Created by Bar Molot on 02/02/2019.
//  Copyright © 2019 Bar Molot. All rights reserved.
//

import UIKit
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
        
        self.descriptionTextView.textColor = UIColor.lightGray
        self.descriptionTextView.delegate = self
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
        PostDao.createPost(author: uid, image: image, description: self.descriptionTextView.text)
        self.tabBarController?.selectedIndex = 0
        self.resetUpload()
    }
    
    func resetUpload() {
        self.uploadImageView.image = nil
        self.descriptionTextView.text = ""
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
