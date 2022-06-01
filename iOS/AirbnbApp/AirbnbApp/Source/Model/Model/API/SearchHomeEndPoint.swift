//
//  SearchHomeEndPoint.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation
import Alamofire

enum SearchHomeEndPoint: Requestable {
    case nearDestination(coordinate: Coordinate)
    case heroBanner
    case themeJourney
}

extension SearchHomeEndPoint {
    var baseUrl: URL? {
        switch self {
        case .nearDestination, .heroBanner, .themeJourney:
            return URL(string: "http://3.34.196.158/api")
        }
    }
    
    var path: String? {
        switch self {
        case .nearDestination:
            return "/place"
        case .heroBanner, .themeJourney:
            return "/events"
        }
    }
    
    var fullUrl: URL? {
        return baseUrl?.appendingPathComponent(path ?? "")
    }
    
    var parameter: [String: Any]? {
        switch self {
        case .nearDestination(let coordinate):
            return ["category_tag": "map",
                    "lat": "\(coordinate.lat)",
                    "lng": "\(coordinate.lng)"]
        case .heroBanner:
            return ["category_tag": "main"]
        case .themeJourney:
            return ["category_tag": "list"]
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .nearDestination, .heroBanner, .themeJourney:
            return .get
        }
    }
}
