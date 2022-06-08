//
//  HeadCountButton.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/07.
//

import UIKit.UIColor

enum HeadCountButton {
    case plus
    case minus
    
    var title: String {
        switch self {
        case .plus:
            return .HeadCount.plus
        case .minus:
            return .HeadCount.minus
        }
    }
    
    var color: UIColor {
        switch self {
        case .plus:
            return .Custom.gray1
        case .minus:
            return .Custom.gray5
        }
    }
    
}
