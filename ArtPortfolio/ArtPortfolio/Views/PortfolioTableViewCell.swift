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
    weak var thumbsupDelegate: ThumbsupCellDelegate?
    
    var portfolio: Posts? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
    }
    
    override func prepareForReuse() {
         portfolioImageView.image = nil
        thumbsUpButton.setImage(UIImage(named: "like"), for: .normal)
    }
    
    func updateViews() {
        guard let portfolio = portfolio else {return}

        titleLabel.text = portfolio.postName
        numberOfLikesLabel.text = String(portfolio.upvotes)
        guard let image = portfolio.imageUrl else {return}
        guard let imageUrl = URL(string: image), let imageData = try? Data(contentsOf: imageUrl) else {return}
        portfolioImageView.image = UIImage(data: imageData)
    
        portfolioImageView.layer.cornerRadius = 10
        portfolioImageView.layer.borderColor = .imageBorderColor
        portfolioImageView.layer.borderWidth = 1
       
    }

    
    @IBAction func thumbsUpButtonPressed(_ sender: UIButton) {
        print("Button Pressed!")
        thumbsupDelegate?.tappedThumbsUp(on: self)
    }
    
    @IBAction func readMoreButtonTapped(_ sender: UIButton) {
        
        delegate?.tappedReadMoreButton(on: self)
    }
}
