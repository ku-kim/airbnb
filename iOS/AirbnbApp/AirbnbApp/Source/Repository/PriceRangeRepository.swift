//
//  PriceRangeRepository.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/02.
//

import Foundation

protocol PriceRangeRepository {
    
    func requestPriceRange(at coordinate: Coordinate,
                           completion: @escaping (Result<PriceRangeEntity, NetworkError>) -> Void)
}
