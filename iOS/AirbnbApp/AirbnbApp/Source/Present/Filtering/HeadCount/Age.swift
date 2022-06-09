//
//  Age.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/07.
//

import Foundation

enum Age: CaseIterable {
    case adult
    case kid
    case toddler
    
    var title: String {
        switch self {
        case .adult:
            return .Age.Title.adult
        case .kid:
            return .Age.Title.kid
        case .toddler:
            return .Age.Title.toddler
        }
    }
    
    var description: String {
        switch self {
        case .adult:
            return .Age.Description.adult
        case .kid:
            return .Age.Description.kid
        case .toddler:
            return .Age.Description.toddler
        }
    }
    
    var index: Int {
        switch self {
        case .adult:
            return 0
        case .kid:
            return 1
        case .toddler:
            return 2
        }
    }
}
