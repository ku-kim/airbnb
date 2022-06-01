//
//  NearCityViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/30.
//

import Foundation

final class NearCityViewModel: ViewModelBindable {
    
    typealias actionType = Void
    typealias stateType = [SearchHomeCellViewModel]
    
    private(set) var loadAction = PublishRelay<actionType>()
    private(set) var loadedState = PublishRelay<stateType>()
    
    @NetworkInject(keypath: \.searchHomeRepositoryImplement)
    private var repository: SearchHomeRepositoryImpl
    
    init() {
        loadAction.bind(onNext: { [weak self] in
            self?.repository.requestNearDestination(coordinate: Coordinate(lat: 37.5, lng: 127.1)) { result in
                switch result {
                case .success(let nearCity):
                    let viewModels = nearCity
                        .cities
                        .map { CityCellViewModel(city: $0) }
                    self?.loadedState.accept(viewModels)
                case .failure(let error):
                    print(error.localizedDescription) // TODO: Error 처리
                }
            }
        })
    }
}

// MARK: - Providing Function

extension NearCityViewModel {
    
    func accept(_ value: actionType) {
        loadAction.accept(value)
    }
    
    func bind(_ completion: @escaping (stateType) -> Void) {
        loadedState.bind(onNext: completion)
    }
    
}
