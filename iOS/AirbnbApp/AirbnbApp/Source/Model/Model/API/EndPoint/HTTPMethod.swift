//
//  HTTPMethod.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation

enum HTTPMethod: String {
    case get
    case post
    
    var value: String {
        self.rawValue.uppercased()
    }
}
