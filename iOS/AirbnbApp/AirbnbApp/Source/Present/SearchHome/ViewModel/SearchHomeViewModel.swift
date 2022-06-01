//
//  SearchHomeViewModel.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/25.
//

import Foundation

final class SearchHomeViewModel {
    
    private var bannerViewModel = BannerSectionViewModel()
    private(set) var nearCitiesViewModel = CitySectionViewModel()
    private var themeViewModel = ThemeSectionViewModel()
      
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
    
    func bindNearCities(completion: @escaping ([SearchHomeCellViewModelable]) -> Void) {
        nearCitiesViewModel.bind(completion)
    }
    
    func bindHeroBanner(completion: @escaping ([SearchHomeCellViewModelable]) -> Void) {
        bannerViewModel.bind(completion)
    }
    
    func bindTheme(completion: @escaping ([SearchHomeCellViewModelable]) -> Void) {
        themeViewModel.bind(completion)
    }
}
