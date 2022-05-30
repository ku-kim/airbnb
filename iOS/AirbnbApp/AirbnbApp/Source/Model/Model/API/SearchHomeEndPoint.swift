//
//  SearchHomeEndPoint.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation
import Alamofire

enum SearchHomeEndPoint: Requestable {
    case nearDestination(latitude: Double, longtitude: Double)
    case heroBanner
    case themeJourney
}

extension SearchHomeEndPoint {
    var baseUrl: URL? {
        switch self {
        case .nearDestination, .heroBanner, .themeJourney:
            return URL(string: "https://64b821c3-c430-4534-be15-75a65a45b818.mock.pstmn.io/api")
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
        case .nearDestination(let latitude, let longtitue):
            return ["category_tag": "map",
                    "lat": "\(latitude)",
                    "lng": "\(longtitue)"]
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
