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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    
    @IBOutlet weak var readMoreButton: UIButton!
    
    @IBOutlet weak var thumbsUpButton: UIButton!
    
    weak var delegate: PortfolioCellDelegate?
    
    var portfolio: Posts? {
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

        titleLabel.text = portfolio.description
        numberOfLikesLabel.text = String(portfolio.upvotes)
        guard let imageUrl = URL(string: portfolio.imageUrl), let imageData = try? Data(contentsOf: imageUrl) else {return}
        portfolioImageView.image = UIImage(data: imageData)
        portfolioImageView.layer.cornerRadius = 10
        portfolioImageView.layer.borderColor = .imageBorderColor
        portfolioImageView.layer.borderWidth = 1
    }

    
    @IBAction func thumbsUpButtonPressed(_ sender: UIButton) {
        print("Button Pressed!")
    }
    
    @IBAction func readMoreButtonTapped(_ sender: UIButton) {
        
        delegate?.tappedReadMoreButton(on: self)
    }
}
