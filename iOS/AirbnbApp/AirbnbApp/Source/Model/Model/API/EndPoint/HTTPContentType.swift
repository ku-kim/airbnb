//
//  HTTPContentType.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation

enum HTTPContentType: String {
    case json
    
    var value: String {
        switch self {
        case .json:
            return "application/json"
        }
    }
}
