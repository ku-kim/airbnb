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
            return "성인"
        case .kid:
            return "어린이"
        case .toddler:
            return "유아"
        }
    }
    
    var description: String {
        switch self {
        case .adult:
            return "만 13세 이상"
        case .kid:
            return "만 2~12세"
        case .toddler:
            return "만 2세 미만"
        }
    }
}
