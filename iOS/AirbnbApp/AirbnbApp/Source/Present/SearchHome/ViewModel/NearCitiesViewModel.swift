//
//  NearCitiesViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/30.
//

import Foundation

final class NearCitiesViewModel: ViewModelBindable {
    
    typealias actionType = Void
    typealias stateType = [SearchHomeEntity.City]
    
    private(set) var loadAction = PublishRelay<actionType>()
    private(set) var loadedState = PublishRelay<stateType>()
    
    let repository = SearchHomeRepositoryImpl() // TODO: 주입?
    
    init() {
        loadAction.bind(onNext: { [weak self] in
                self?.repository.requestNearDestination(latitude: 35.1, longtitude: 123.1) { result in
                    switch result {
                    case .success(let entity):
                        self?.loadedState.accept(entity.nearCities)
                    case .failure(let error):
                        print(error.localizedDescription) // TODO: Error 처리
                    }
                }
            })
    }
}

// MARK: - Providing Function

extension NearCitiesViewModel {
    
    func accept(_ value: actionType) {
        loadAction.accept(value)
    }
    
    func bind(_ completion: @escaping (stateType) -> Void) {
        loadedState.bind(onNext: completion)
    }
    
}
