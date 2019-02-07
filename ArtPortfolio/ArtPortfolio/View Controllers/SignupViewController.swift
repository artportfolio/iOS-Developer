//
//  SignupViewController.swift
//  ArtPortfolio
//
//  Created by Nelson Gonzalez on 2/4/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import ProgressHUD

class SignupViewController: UIViewController, UITextFieldDelegate {
    
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
        usernameTextField.delegate = self
        fullNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
            
            ProgressHUD.showSuccess()
            
            DispatchQueue.main.async {
                let viewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondLoginVC") as UIViewController
                
                self.present(viewController, animated: true, completion: nil)
           
            }
            
            print("Registered OK")
        }
        
       
    }
    
}
