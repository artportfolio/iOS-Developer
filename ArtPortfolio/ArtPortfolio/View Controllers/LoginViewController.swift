//
//  ViewController.swift
//  Art-Portfolio
//
//  Created by Nelson Gonzalez on 2/1/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit
import ProgressHUD

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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
                ProgressHUD.showError(error.localizedDescription)
                return
            }
            DispatchQueue.main.async {
                let viewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBar") as UIViewController
                
                self.present(viewController, animated: true, completion: nil)
            }
          
            
        }
        
    }
    
}

