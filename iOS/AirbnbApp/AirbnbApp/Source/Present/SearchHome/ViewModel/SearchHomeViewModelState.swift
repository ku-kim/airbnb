//
//  SearchHomeViewModelState.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation

protocol SearchHomeViewModelState {
    var loadedHeader: PublishRelay<[String]> { get }
    var loadedNearCities: PublishRelay<[SearchHomeEntity.City]> { get }
    var loadedHeroBanner: PublishRelay<[SearchHomeEntity.Banner]> { get }
    var loadedTheme: PublishRelay<[String]> { get }
}
