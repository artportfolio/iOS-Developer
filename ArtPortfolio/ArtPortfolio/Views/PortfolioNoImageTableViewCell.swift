//
//  PortfolioNoImageTableViewCell.swift
//  ArtPortfolio
//
//  Created by Nelson Gonzalez on 2/7/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class PortfolioNoImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titlelabel: UILabel!
    
    @IBOutlet weak var thumbsUpButton: UIButton!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    
    @IBOutlet weak var learnMoreBbutton: UIButton!
    
    
    var posts: Posts? {
        didSet {
            updateViews()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateViews(){
        guard let posts = posts else {return}
        
        titlelabel.text = posts.postName
        numberOfLikesLabel.text = String(posts.upvotes)
    }

   
    @IBAction func learnMoreButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func thumbsUpButtonPressed(_ sender: UIButton) {
    }
    
    
}
