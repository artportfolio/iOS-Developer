//
//  PortfolioTableViewCell.swift
//  Art-Portfolio
//
//  Created by Nelson Gonzalez on 2/2/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell {
    
    @IBOutlet weak var portfolioImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    
    var portfolio: Users? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateViews() {
        guard let portfolio = portfolio else {return}
        
        descriptionLabel.text = portfolio.posts.postDescription
        numberOfLikesLabel.text = String(portfolio.posts.likes)
        guard let imageUrl = URL(string: portfolio.posts.imageUrl), let imageData = try? Data(contentsOf: imageUrl) else {return}
        portfolioImageView.image = UIImage(data: imageData)
    }

    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
    }
    
}
