//
//  CustomLabel.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/26.
//

import UIKit

class CustomLabel: UILabel {
    
    convenience init(text: String? = nil, font: UIFont?, fontColor: UIColor) {
        self.init()
        configureFont(text: text, font: font, textColor: fontColor)
    }
}

private extension CustomLabel {
    func configureFont(text: String? = nil, font: UIFont?, textColor: UIColor) {
        self.text = text
        self.font = font
        self.textColor = textColor
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
    }
}
