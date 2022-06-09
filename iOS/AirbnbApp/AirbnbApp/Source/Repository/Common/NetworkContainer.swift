//
//  NetworkContainer.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/31.
//

import Foundation

final class NetworkContainer {
    
    static var shared = NetworkContainer()
    
    private init() { }
    
    lazy var imageManager = ImageManager()
    lazy var searchHomeRepository: SearchHomeRepository = SearchHomeRepositoryImpl()
    lazy var priceRangeRepository: PriceRangeRepository = PriceRangeRepositoryImpl()
    lazy var locationRepository: LocationRepository = LocationRepository()
}
