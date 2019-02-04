//
//  WelcomeViewController.swift
//  ArtPortfolio
//
//  Created by Nelson Gonzalez on 2/4/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var guestLoginButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appearance()

        
       
    }
    

    private func appearance() {
        titleLabel.font = AppearanceHelper.applicationFont(with: .headline, pointSize: 60)
        signInLabel.font = AppearanceHelper.applicationFont(with: .body, pointSize: 15)
        
        AppearanceHelper.style(button: loginButton)
        AppearanceHelper.style(button: guestLoginButton)
        
        imageView.layer.cornerRadius = 20
    }
    

}
