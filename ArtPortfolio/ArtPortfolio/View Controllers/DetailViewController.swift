//
//  DetailViewController.swift
//  ArtPortfolio
//
//  Created by Nelson Gonzalez on 2/4/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import ProgressHUD

class DetailViewController: UIViewController, UITextFieldDelegate , UITextViewDelegate {
    @IBOutlet weak var artImageView: UIImageView!
    
    @IBOutlet weak var artDescriptionTextView: UITextView!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var submitButtom: UIButton!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var portfolioController: PortfolioController?
    var portfolio: Posts?

    var postId: Int!

    override func viewDidLoad() {
        super.viewDidLoad()


        updateViews()
     
        updateAppearance()
    
        titleTextField.delegate = self
        artDescriptionTextView.delegate = self
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            artDescriptionTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func updateViews() {
        guard let portfolios = portfolio else {return}
        postId = portfolios.id
        titleTextField.text = portfolios.postName
        
        artDescriptionTextView.text = portfolios.description
        
        if let imageURL = URL(string: portfolios.imageUrl!), let imageData = try? Data(contentsOf: imageURL) {
            artImageView.image = UIImage(data: imageData)
        }

       
        
        let userDefaults = UserDefaults.standard
        if portfolios.userId == userDefaults.integer(forKey: "userId") {
            editButton.isHidden = false
            submitButtom.isHidden = false
            deleteButton.isHidden = false
           // artDescriptionTextView.isEditable = true
        } else {
            editButton.isHidden = true
            submitButtom.isHidden = true
            deleteButton.isHidden = true
           // artDescriptionTextView.isEditable = false
        }
        
    }
    
    func updateAppearance() {
        artImageView.layer.cornerRadius = 20
        artImageView.layer.borderColor = .imageBorderColor
        artImageView.layer.borderWidth = 1
        AppearanceHelper.style(button: submitButtom)
        artDescriptionTextView.font = AppearanceHelper.applicationFont(with: .body, pointSize: 15)
        artDescriptionTextView.textColor = .textColor
        deleteButton.layer.backgroundColor = UIColor.red.cgColor
        editButton.setTitleColor(.textColor, for: .normal)
        deleteButton.layer.cornerRadius = 8
        deleteButton.setTitleColor(.textColor, for: .normal)
        artDescriptionTextView.keyboardAppearance = .dark
    }

    @IBAction func editButtonPressed(_ sender: UIButton) {
        
        artDescriptionTextView.isEditable = true
        
        
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        ProgressHUD.show("Editing...", interaction: true)
        
        portfolioController?.editPostWith(id: postId, postName: titleTextField.text, imageUrl: nil, description: artDescriptionTextView.text, completion: { (error) in
            if let error = error {
                print("Error editing post: \(error.localizedDescription)")
                ProgressHUD.showError(error.localizedDescription, interaction: true)
            }
            DispatchQueue.main.async {
                ProgressHUD.showSuccess()
            }
            
            
        })
        
    }
    
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        
        print("PostID: \(postId!)")
        
        ProgressHUD.show("Deleting....", interaction: true)
        
        portfolioController?.deletePost(postId: postId!, completion: { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.updateUI()
                
                ProgressHUD.showSuccess("Post Deleted!")
                
            }
        })
        
    }
    
    func updateUI(){
        titleTextField.text = nil
        artDescriptionTextView.text = nil
    }
    
}
