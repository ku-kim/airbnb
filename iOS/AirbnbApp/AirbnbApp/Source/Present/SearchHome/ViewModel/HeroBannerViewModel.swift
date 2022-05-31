//
//  HeroBannerViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/30.
//

import Foundation

final class HeroBannerViewModel: ViewModelBindable {
    typealias actionType = Void
    typealias stateType = [SearchHomeEntity.Banner]
    
    private(set) var loadAction = PublishRelay<actionType>()
    private(set) var loadedState = PublishRelay<stateType>()
    
    let repository = SearchHomeRepositoryImpl() // TODO: 주입?
    
    init() {
        loadAction.bind(onNext: { [weak self] in
            self?.repository.requestHeroBanner { result in
                switch result {
                case .success(let heroBanner):
                    self?.loadedState.accept(heroBanner.banners)
                case .failure(let error):
                    print(error.localizedDescription) // TODO: Error 처리
                }
            }
        })
    }
}

// MARK: - Providing Function

extension HeroBannerViewModel {
    
    func accept(_ value: actionType) {
        loadAction.accept(value)
    }
    
    func bind(_ completion: @escaping (stateType) -> Void) {
        loadedState.bind(onNext: completion)
    }
    
}