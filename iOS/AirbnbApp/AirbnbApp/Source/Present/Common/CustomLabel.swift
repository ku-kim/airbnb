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
        self.text = "asdasdsadsadsa"
        configureFont(text: text, font: font, fontColor: fontColor)
    }
}

private extension CustomLabel {
    func configureFont(text: String? = nil, font: UIFont?, fontColor: UIColor) {
        self.text = text
        self.font = font
        self.textColor = fontColor
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
    
    }
}
