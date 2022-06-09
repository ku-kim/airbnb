//
//  PriceRangeRepository.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/02.
//

import Foundation

protocol PriceRangeRepository {
    
    func requestPriceRange(from resource: String, with extension: String,
                           completion: @escaping (Result<PriceRangeEntity, NetworkError>) -> Void)
    
    func requestPriceRange(at coordinate: Coordinate,
                           completion: @escaping (Result<PriceRangeEntity, NetworkError>) -> Void)
}
