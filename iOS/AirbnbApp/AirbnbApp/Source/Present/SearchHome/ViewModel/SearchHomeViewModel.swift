//
//  SearchHomeViewModel.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/25.
//

import Foundation
import SwiftUI

final class SearchHomeViewModel {
    
    private var headerViewModel = HeaderViewModel()
    private var bannerViewModel = HeroBannerViewModel()
    private var nearCitiesViewModel = NearCityViewModel()
    private var themeViewModel = ThemeJourneyViewModel()
    
    let repository = SearchHomeRepositoryImpl() // TODO: 주입?
    
}

// MARK: - Providing Function

extension SearchHomeViewModel {
    
    func acceptHeader(value: Void) {
        headerViewModel.accept(value)
    }
    
    func acceptNearCities(value: Void) {
        nearCitiesViewModel.accept(value)
    }
    
    func acceptHeroBanner(value: Void) {
        bannerViewModel.accept(value)
    }
    
    func acceptTheme(value: Void) {
        themeViewModel.accept(value)
    }
    
    func bindNearCities(completion: @escaping ([SearchHomeEntity.City]) -> Void) {
        nearCitiesViewModel.bind(completion)
    }
    
    func bindHeroBanner(completion: @escaping ([SearchHomeEntity.Banner]) -> Void) {
        bannerViewModel.bind(completion)
    }
    
    func bindHeader(completion: @escaping ([String]) -> Void) {
        headerViewModel.bind(completion)
    }
    
    func bindTheme(completion: @escaping ([SearchHomeEntity.Theme]) -> Void) {
        themeViewModel.bind(completion)
    }
}
