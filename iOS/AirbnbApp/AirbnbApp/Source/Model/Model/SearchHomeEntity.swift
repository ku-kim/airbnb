//
//  SearchHomeEntity.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation

struct SearchHomeEntity { }

extension SearchHomeEntity {
    struct NearCity: Decodable {
        let cities: [City]
        
        enum CodingKeys: String, CodingKey {
            case cities = "data"
        }
    }
    
    struct City: Decodable {
        let cityName: String
        let imageUrl: String
        let time: Int
        
        enum CodingKeys: String, CodingKey {
            case cityName = "title"
            case imageUrl
            case time
        }
    }
}

extension SearchHomeEntity {
    struct HeroBanner: Decodable {
        let banners: [Banner]
        
        enum CodingKeys: String, CodingKey {
            case banners = "data"
        }
    }
    
    struct Banner: Decodable {
        let title: String
        let description: String
        let imageUrl: String
        
        enum CodingKeys: String, CodingKey {
            case title
            case description
            case imageUrl
        }
    }
}

extension SearchHomeEntity {
    struct ThemeJourney: Decodable {
        let themes: [Theme]
        
        enum CodingKeys: String, CodingKey {
            case themes = "data"
        }
        
    }
    
    struct Theme: Decodable {
        let title: String
        let imageUrl: String
        
        enum CodingKeys: String, CodingKey {
            case title
            case imageUrl
        }
    }
    
}
