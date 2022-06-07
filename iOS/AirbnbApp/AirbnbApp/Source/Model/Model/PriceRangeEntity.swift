//
//  PriceRangeEntity.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/02.
//

import Foundation

struct PriceRangeEntity: Decodable {
    let priceRange: PriceRange
    
    enum CodingKeys: String, CodingKey {
        case priceRange = "data"
    }
}

struct PriceRange: Decodable {
    let averagePrice: Int
    let histogram: [Histogram]
    
    enum CodingKeys: String, CodingKey {
        case averagePrice = "average_price"
        case histogram
    }
}

struct Histogram: Decodable {
    let min: Int
    let max: Int?
    let count: Int
}
