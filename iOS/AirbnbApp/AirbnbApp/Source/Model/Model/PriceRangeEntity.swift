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

extension PriceRangeEntity {
    struct PriceRange: Decodable {
        let averagePrice: Double
        let histogram: [Histogram]
        
        enum CodingKeys: String, CodingKey {
            case averagePrice = "average"
            case histogram = "histogramBins"
        }
    }

    struct Histogram: Decodable, Comparable {
        static func < (lhs: Histogram, rhs: Histogram) -> Bool {
            return lhs.count < rhs.count
        }
        
        let min: Int
        let max: Int?
        let count: Int
    }
}
