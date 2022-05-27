//
//  EndPointable.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation

protocol EndPointable {
    var baseURL: URL? { get }
    var path: String? { get }
    var parameter: [String: Any]? { get }
    var method: HTTPMethod { get }
    var content: HTTPContentType { get }
}

extension EndPointable {
    var header: [String: String]? {
        ["Content-Type": content.value]
    }
}
