//
//  AddPostsViewController.swift
//  ArtPortfolio
//
//  Created by Nelson Gonzalez on 2/5/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import ProgressHUD

class AddPostsViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var postTitleTextField: UITextField!
    
    @IBOutlet weak var postDescriptionTextView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    @IBOutlet weak var imageUrlTextField: UITextField!
    
    
    var portfolioController = PortfolioController()
    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        setApparance()
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(self.handleSelectProfileImageView))
        postImageView.addGestureRecognizer(tapGesture)
        //make image interactable
        postImageView.isUserInteractionEnabled = true
        
       postDescriptionTextView.delegate = self
      postDescriptionTextView.text = "Please write a description for you post here ..."
      
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func setApparance(){
        postDescriptionTextView.font = AppearanceHelper.applicationFont(with: .body, pointSize: 15)
        postDescriptionTextView.textColor = .textColor
        postImageView.layer.cornerRadius = 10
        AppearanceHelper.style(button: postButton)
        postDescriptionTextView.keyboardAppearance = .dark
        
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        
            postDescriptionTextView.text = nil
        
        }
   
 
    func textViewDidEndEditing(_ textView: UITextView) {

        postDescriptionTextView.text = "Please write a description for you post here ..."
  
}
  
    @IBAction func postButtonPressed(_ sender: UIButton) {

        if let postTitle = postTitleTextField.text, !postTitle.isEmpty {
            portfolioController.createPostsWith(postName: postTitle, imageUrl: imageUrlTextField.text ?? nil, description: postDescriptionTextView.text ?? nil) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    ProgressHUD.showError(error.localizedDescription)
                }
                ProgressHUD.showSuccess()
                DispatchQueue.main.async {
                    self.clearView()
                }
 
            }
        }
        
    }
    
    
    func clearView(){
        postImageView.image = nil
        postTitleTextField.text = nil
        postDescriptionTextView.text = nil
        imageUrlTextField.text = nil
    }
    
    @IBAction func logoutBarButtonPressed(_ sender: UIBarButtonItem) {
        
        let userDefults = UserDefaults.standard
        userDefults.set(nil, forKey: "token")
        userDefults.set(nil, forKey: "userId")
        
        let viewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeNavBar") as UIViewController
        
        self.present(viewController, animated: true, completion: nil)
        
    }
    
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have perission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func handleSelectProfileImageView() {
        print("TAPPED")
        //bring up the image picker controller
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Photo Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// to be able to pick images from library
extension AddPostsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("did Finish Picking Media")
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImage = editedImage
            postImageView.image = editedImage
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            selectedImage = image
            postImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
