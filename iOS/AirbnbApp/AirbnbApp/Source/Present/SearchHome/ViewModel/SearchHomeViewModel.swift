//
//  SearchHomeViewModel.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/25.
//

import Foundation

final class SearchHomeViewModel: SearchHomeViewModelBindable {
    
    func action() -> SearchHomeViewModelAction { self }
    var loadHeader = PublishRelay<Void>()
    var loadHeroBanner = PublishRelay<Void>()
    var loadNearCities = PublishRelay<Void>()
    var loadTheme = PublishRelay<Void>()
    
    func state() -> SearchHomeViewModelState { self }
    var loadedHeader = PublishRelay<[String]>()
    var loadedHeroBanner = PublishRelay<[SearchHomeEntity.Banner]>()
    var loadedNearCities = PublishRelay<[SearchHomeEntity.City]>()
    var loadedTheme = PublishRelay<[String]>()
    
    let repository = SearchHomeRepositoryImpl() // TODO: 주입?
    
    init() {
        action().loadHeader
            .bind(onNext: { [weak self] in
                self?.state().loadedHeader.accept(["", "가까운 여행지 둘러보기", "어디에서나, 여행은 살아보는거야!"])
            })
        
        action().loadNearCities
            .bind(onNext: { [weak self] in
                self?.repository.requestNearDestination(latitude: 35.1, longtitude: 123.1) { result in
                    switch result {
                    case .success(let entity):
                        self?.state().loadedNearCities.accept(entity.nearCities)
                    case .failure(let error):
                        print(error.localizedDescription) // TODO: Error 처리
                    }
                }
            })
        
        action().loadHeroBanner
            .bind(onNext: { [weak self] in
                self?.repository.requestHeroBanner { result in
                    switch result {
                    case .success(let entity):
                        self?.state().loadedHeroBanner.accept(entity.banners)
                    case .failure(let error):
                        print(error.localizedDescription) // TODO: Error 처리
                    }
                }
            })
        
        action().loadTheme
            .bind(onNext: { [weak self] in
                self?.state().loadedTheme.accept(["자연생활을 만끽할 수 있는 숙소", "독특한 공간"])
            })
    }
}

// MARK: - Providing Function

extension SearchHomeViewModel {
    
    func acceptHeader(value: Void) {
        action().loadHeader.accept(value)
    }
    
    func acceptNearCities(value: Void) {
        action().loadNearCities.accept(value)
    }
    
    func acceptHeroBanner(value: Void) {
        action().loadHeroBanner.accept(value)
    }
    
    func acceptTheme(value: Void) {
        action().loadTheme.accept(value)
    }
    
    func bindNearCities(completion: @escaping ([SearchHomeEntity.City]) -> Void) {
        state().loadedNearCities.bind(onNext: completion)
    }
    
    func bindHeroBanner(completion: @escaping ([SearchHomeEntity.Banner]) -> Void) {
        state().loadedHeroBanner.bind(onNext: completion)
    }
    
    func bindHeader(completion: @escaping ([String]) -> Void) {
        state().loadedHeader.bind(onNext: completion)
    }
    
    func bindTheme(completion: @escaping ([String]) -> Void) {
        state().loadedTheme.bind(onNext: completion)
    }
}
