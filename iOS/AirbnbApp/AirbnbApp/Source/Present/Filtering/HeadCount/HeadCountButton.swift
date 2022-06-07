//
//  HeadCountButton.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/07.
//

import Foundation

enum HeadCountButton {
    case plus
    case minus
    
    var title: String {
        switch self {
        case .plus:
            return "+"
        case .minus:
            return "-"
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
