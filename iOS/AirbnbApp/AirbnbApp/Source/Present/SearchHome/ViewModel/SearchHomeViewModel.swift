//
//  SearchHomeViewModel.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/25.
//

import Foundation

final class SearchHomeViewModel {
    
    private var bannerViewModel = HeroBannerViewModel()
    private(set) var nearCitiesViewModel = NearCityViewModel()
    private var themeViewModel = ThemeJourneyViewModel()
      
    @NetworkInject(keypath: \.searchHomeRepositoryImplement)
    private var repository: SearchHomeRepositoryImpl
    
}

// MARK: - Providing Function

extension SearchHomeViewModel {
    
    func acceptNearCities(value: Void) {
        nearCitiesViewModel.accept(value)
    }
    
    func acceptHeroBanner(value: Void) {
        bannerViewModel.accept(value)
    }
    
    func acceptTheme(value: Void) {
        themeViewModel.accept(value)
    }
    
    func bindNearCities(completion: @escaping ([SearchHomeCellViewModel]) -> Void) {
        nearCitiesViewModel.bind(completion)
    }
    
    func bindHeroBanner(completion: @escaping ([SearchHomeCellViewModel]) -> Void) {
        bannerViewModel.bind(completion)
    }
    
    func bindTheme(completion: @escaping ([SearchHomeCellViewModel]) -> Void) {
        themeViewModel.bind(completion)
    }
}
