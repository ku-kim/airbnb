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
    case priceRange(coordinate: Coordinate)
}

extension SearchHomeEndPoint {
    
    var baseUrl: URL? {
        switch self {
        case .city, .banner, .theme, .priceRange:
            return URL(string: "http://52.78.229.26/api")
        }
    }
    
    var path: String? {
        switch self {
        case .city:
            return "/place"
        case .banner, .theme:
            return "/events"
        case .priceRange:
            return "/rooms"
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
        case .priceRange(let coordinate):
            return ["category_tag": "histogram",
                    "lat": "\(coordinate.lat)",
                    "lng": "\(coordinate.lng)"]
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .city, .banner, .theme, .priceRange:
            return .get
        }
    }
    
}
