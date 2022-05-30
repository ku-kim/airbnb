//
//  NetworkError.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case failToDecode
    case emptyData
}
