//
//  SearchHomeViewModel.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/25.
//

import Foundation

final class SearchHomeViewModel {
    
    private var bannerViewModel = BannerViewModel()
    private var cityViewModel = CityViewModel()
    private var themeViewModel = ThemeViewModel()
      
    @NetworkInject(keypath: \.searchHomeRepositoryImplement)
    private var repository: SearchHomeRepositoryImpl
    
}

// MARK: - Providing Function

extension SearchHomeViewModel {
    
    func acceptNearCity(value: Void) {
        cityViewModel.accept(value)
    }
    
    func acceptHeroBanner(value: Void) {
        bannerViewModel.accept(value)
    }
    
    func acceptTheme(value: Void) {
        themeViewModel.accept(value)
    }
    
    func bindCities(completion: @escaping ([CellViewModelable]) -> Void) {
        cityViewModel.bind(completion)
    }
    
    func bindHeroBanner(completion: @escaping ([CellViewModelable]) -> Void) {
        bannerViewModel.bind(completion)
    }
    
    func bindTheme(completion: @escaping ([CellViewModelable]) -> Void) {
        themeViewModel.bind(completion)
    }
}
