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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewAppearance()
    }
    
    private func viewAppearance(){
        loginLabel.textColor = .textColor
        loginLabel.font = AppearanceHelper.applicationFont(with: .headline, pointSize: 15)
        AppearanceHelper.style(button: loginButton)
    }
    

    @IBAction func loginButtonPressed(_ sender: UIButton) {
    }
    
}

