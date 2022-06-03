//
//  CityViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/30.
//

import Foundation

final class CityViewModel: ViewModelBindable {
    
    let loadAction = PublishRelay<Void>()
    let loadedState = PublishRelay<[CellViewModelable]>()
    
    @NetworkInject(keypath: \.searchHomeRepositoryImplement)
    private var repository: SearchHomeRepositoryImpl
    
    init() {
        loadAction.bind(onNext: { [weak self] in
            self?.repository.requestNearCity(at: Coordinate(lat: 37.5, lng: 127.1)) { result in
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
