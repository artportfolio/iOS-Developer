//
//  SignupViewController.swift
//  ArtPortfolio
//
//  Created by Nelson Gonzalez on 2/4/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewAppearance()
        
    }
    
    private func viewAppearance(){
        AppearanceHelper.style(button: signUpButton)
    }
    
    

   
    @IBAction func signupButtonPressed(_ sender: UIButton) {
    }
    
}
