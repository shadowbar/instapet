//
//  UploadViewController.swift
//  instapet
//
//  Created by Bar Molot on 02/02/2019.
//  Copyright © 2019 Bar Molot. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController {
    
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var uploadButton: UIButton!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker = UIImagePickerController()
        self.imagePicker.allowsEditing = true
        self.imagePicker.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        self.uploadImageView.isUserInteractionEnabled = true
        self.uploadImageView.addGestureRecognizer(tapGestureRecognizer)
        
        //        descriptionTextView.delegate = self
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadTap(_ sender: Any) {
        guard let uid = AuthenticationDAO.getUserId() else { return }
        guard let image = self.uploadImageView.image else { return }
        PostDao.createPost(author: uid, image: image, description: self.descriptionTextView.text)
        self.tabBarController?.selectedIndex = 0
        resetUpload()
    }
    
    func resetUpload() {
        self.uploadImageView.image = nil
        self.descriptionTextView.text = ""
    }
}

//extension UploadViewController: UITextViewDelegate {
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.textColor == UIColor.lightGray {
//            textView.text = nil
//            textView.textColor = UIColor.black
//        }
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = "Please insert description about the pet."
//            textView.textColor = UIColor.lightGray
//        }
//    }
//}

extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        
        uploadImageView.image = selectedImage
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
