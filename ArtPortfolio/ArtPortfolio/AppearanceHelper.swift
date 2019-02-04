//
//  AppearanceHelper.swift
//  ArtPortfolio
//
//  Created by Nelson Gonzalez on 2/4/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

enum AppearanceHelper {
    
//    static var lambdaRed = UIColor(red: 212.0/255.0, green: 87.0/255.0, blue: 80.0/255.0, alpha: 1.0)
//    static var backgroundGray = UIColor(red: 45.0/255.0, green: 45.0/255.0, blue: 45.0/255.0, alpha: 1.0)
//
    
    static func setupAppearance(){
        //Change the apperance for all instances of UINavigationBar.
        //appearance proxy will set for all instances in our app.
        UINavigationBar.appearance().barTintColor = .navBarTintColor

//        UIBarButtonItem.appearance().tintColor = lambdaRed
//        UISegmentedControl.appearance().tintColor = lambdaRed
        
  //      UILabel.appearance().textColor = .textColor
        
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor.navBarTextColor]
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().largeTitleTextAttributes = textAttributes
        
   //     UITableViewCell.appearance().backgroundColor = backgroundGray
        
        //  UIView.appearance(whenContainedInInstancesOf: [UITableView.self]).backgroundColor = backgroundGray
        
//        UITextField.appearance().keyboardAppearance = .dark
//        UITextField.appearance().tintColor = lambdaRed
//        UITextView.appearance().tintColor = lambdaRed
        
        
        
    }
    
    static func applicationFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        let result = UIFont(name: "Varela Round", size: pointSize)!
        //the size of the font scaled.
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: result)
        
    }
    
    
    static func style(button: UIButton) {
        button.titleLabel?.font = applicationFont(with: .callout, pointSize: 20)
        button.setTitleColor(.buttonTextColor, for: .normal)
        button.backgroundColor = .buttonBackgroundColor
        button.layer.cornerRadius = 8
        button.layer.borderColor = .buttonBorderColor
        button.layer.borderWidth = 1
    }
}

extension UIColor {
    static let textColor = UIColor(red: 255/255, green: 252/255, blue: 163/255, alpha: 1)
    
    static let buttonBackgroundColor = UIColor(red: 103/255, green: 158/255, blue: 199/255, alpha: 1)
    
    static let buttonTextColor = UIColor(red: 255/255, green: 252/255, blue: 163/255, alpha: 1)
    
    static let navBarTextColor = UIColor(red: 255/255, green: 252/255, blue: 163/255, alpha: 1)
    
     static let navBarTintColor = UIColor(red: 38/255, green: 57/255, blue: 61/255, alpha: 1)
    
}

extension CGColor {
     static let buttonBorderColor = UIColor(red: 64/255, green: 98/255, blue: 124/255, alpha: 1).cgColor
    static let imageBorderColor = UIColor(red: 255/255, green: 252/255, blue: 163/255, alpha: 1).cgColor
}
