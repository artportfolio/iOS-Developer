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
    
    var portfolioController: PortfolioController?
    var portfolio: Users?

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        editButton.isHidden = true
        
    }
    
    func updateViews() {
        guard let portfolios = portfolio else {return}
        
        artDescriptionTextView.text = portfolios.posts.postDescription
        
        guard let imageURL = URL(string: portfolios.posts.imageUrl), let imageData = try? Data(contentsOf: imageURL) else { return }
        
        artImageView.image = UIImage(data: imageData)
    }
    
   

    @IBAction func editButtonPressed(_ sender: UIButton) {
    }
    

}
