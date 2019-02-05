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
    
    var userController = PortfolioController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewAppearance()
        
    }
    
    private func viewAppearance(){
        AppearanceHelper.style(button: signUpButton)
    }
    
    

   
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        
        
            guard let username = usernameTextField.text, !username.isEmpty, let fullname = fullNameTextField.text, !fullname.isEmpty, let password = passwordTextField.text, !password.isEmpty else {return}
            
            //Signup code

        userController.registerUser(username: username, fullname: fullname, password: password, email: emailTextField.text, userProfileImage: nil) { (error) in
            if let error = error {
                print(error)
            }
            
            print("Registered OK")
        }
        
       
    }
    
   //example
    func signup(email: String?, username: String, fullname: String, passsword: String){
        //done code
        print("Works ok..")
    }
    
}
