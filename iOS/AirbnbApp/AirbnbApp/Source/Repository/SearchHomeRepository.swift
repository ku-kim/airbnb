//
//  SearchHomeRepository.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/29.
//

import Foundation

protocol SearchHomeRepository {
    
    func requestNearDestination(latitude: Double,
                                longtitude: Double,
                                completion: @escaping (Result<SearchHomeEntity.NearCity, NetworkError>) -> Void)
    
    func requestHeroBanner(completion: @escaping (Result<SearchHomeEntity.HeroBanner, NetworkError>) -> Void)
    
    func requestTheme(completion: @escaping (Result<SearchHomeEntity.ThemeJourney, NetworkError>) -> Void)
}
