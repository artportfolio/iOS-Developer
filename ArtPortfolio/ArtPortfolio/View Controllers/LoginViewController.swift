//
//  ViewController.swift
//  Art-Portfolio
//
//  Created by Nelson Gonzalez on 2/1/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var orLabel: UILabel!
    
    @IBOutlet weak var signupButton: UIButton!
    
    var portfolioController = PortfolioController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAppearance()
    }
    
    private func viewAppearance(){
        loginLabel.textColor = .textColor
        loginLabel.font = AppearanceHelper.applicationFont(with: .headline, pointSize: 15)
        AppearanceHelper.style(button: loginButton)
        orLabel.textColor = .textColor
        orLabel.font = AppearanceHelper.applicationFont(with: .headline, pointSize: 15)
        AppearanceHelper.style(button: signupButton)
    }
    

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty, let password = passwordTextField.text, !password.isEmpty else { return }
        
        //login code
        portfolioController.login(username: username, password: password) { (error) in
            if let error = error {
                print("ERROR:: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toTableVCFromLogin", sender: self)
            }
          
            print("Logged in..")
        }
        
    }
    
}

