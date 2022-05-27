//
//  SearchHomeEntity.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation

struct SearchHomeEntity: Decodable {
    let data: [Datum]
}

struct Datum: Decodable {
    let cityName: String
    let imageURL: String
    let time: String
    
    enum CodingKeys: String, CodingKey {
        case cityName = "title"
        case imageURL = "image_url"
        case time
    }
}
