//
//  SearchHomeEndPoint.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation
import Alamofire

enum SearchHomeEndPoint: Requestable {
    case city(coordinate: Coordinate)
    case banner
    case theme
}

extension SearchHomeEndPoint {
    
    var baseUrl: URL? {
        switch self {
        case .city, .banner, .theme:
            return URL(string: "http://3.34.196.158/api")
        }
    }
    
    var path: String? {
        switch self {
        case .city:
            return "/place"
        case .banner, .theme:
            return "/events"
        }
    }
    
    var fullUrl: URL? {
        return baseUrl?.appendingPathComponent(path ?? "")
    }
    
    var parameter: [String: Any]? {
        switch self {
        case .city(let coordinate):
            return ["category_tag": "map",
                    "lat": "\(coordinate.lat)",
                    "lng": "\(coordinate.lng)"]
        case .banner:
            return ["category_tag": "main"]
        case .theme:
            return ["category_tag": "list"]
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .city, .banner, .theme:
            return .get
        }
    }
    
}
