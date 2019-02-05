//
//  DetailViewController.swift
//  ArtPortfolio
//
//  Created by Nelson Gonzalez on 2/4/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var artImageView: UIImageView!
    
    @IBOutlet weak var artDescriptionTextView: UITextView!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var submitButtom: UIButton!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    var portfolioController: PortfolioController?
    var portfolio: Users?

    override func viewDidLoad() {
        super.viewDidLoad()

     //   updateViews()
        editButton.isHidden = true
        submitButtom.isHidden = true
        updateAppearance()
        
    }
    
//    func updateViews() {
//        guard let portfolios = portfolio else {return}
//        
//        artDescriptionTextView.text = portfolios.posts.postDescription
//        
//        guard let imageURL = URL(string: portfolios.posts.imageUrl), let imageData = try? Data(contentsOf: imageURL) else { return }
//        
//        artImageView.image = UIImage(data: imageData)
//    }
    
    func updateAppearance() {
        artImageView.layer.cornerRadius = 20
        artImageView.layer.borderColor = .imageBorderColor
        artImageView.layer.borderWidth = 1
        AppearanceHelper.style(button: submitButtom)
        artDescriptionTextView.font = AppearanceHelper.applicationFont(with: .body, pointSize: 15)
        artDescriptionTextView.textColor = .textColor
    }

    @IBAction func editButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
    }
    
}
