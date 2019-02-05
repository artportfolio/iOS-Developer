//
//  AddPostsViewController.swift
//  ArtPortfolio
//
//  Created by Nelson Gonzalez on 2/5/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class AddPostsViewController: UIViewController {
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var posTitleTextField: UITextField!
    
    @IBOutlet weak var postDescriptionTextVew: UITextView!
    @IBOutlet weak var postButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setApparance()
      
    }
    
    
    func setApparance(){
        postDescriptionTextVew.font = AppearanceHelper.applicationFont(with: .body, pointSize: 15)
        postDescriptionTextVew.textColor = .textColor
    }

  
    @IBAction func postButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func logoutBarButtonPressed(_ sender: UIBarButtonItem) {
        
    }
}
