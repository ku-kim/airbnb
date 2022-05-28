//
//  EndPoint.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation
import Alamofire

enum EndPoint: EndPointable {
    case requestNearDestination(latitude: Double, longtitude: Double)
}

extension EndPoint {
    var baseUrl: URL? {
        switch self {
        case .requestNearDestination:
            return URL(string: "https://64b821c3-c430-4534-be15-75a65a45b818.mock.pstmn.io/api")
        }
    }
    
    var path: String? {
        switch self {
        case .requestNearDestination:
            return "/place"
        }
    }
    
    var fullUrl: Alamofire.URLConvertible? {
        return baseUrl?.appendingPathComponent(path ?? "")
    }
    
    var parameter: [String: Any]? {
        switch self {
        case .requestNearDestination(let latitude, let longtitue):
            return ["category_tag": "map",
                    "lat": "\(latitude)",
                    "lng": "\(longtitue)"]
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .requestNearDestination:
            return .get
        }
    }
}
