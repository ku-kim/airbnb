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
    
    let loadedLocation = PublishRelay<Coordinate>()
    
    @NetworkInject(keypath: \.searchHomeRepository)
    private var repository: SearchHomeRepository
    
    @NetworkInject(keypath: \.locationRepository)
    private var locationManager: LocationRepository
    
    init() {
        loadedLocation.bind { [ weak self] coordinate in
            let lat = coordinate.lat
            let lng = coordinate.lng
            self?.repository.requestNearCity(at: Coordinate(lat: lat, lng: lng)) { result in
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
        }
        locationManager.loadedLocation.bind { [ weak self ] coordinate in
            self?.loadedLocation.accept(coordinate)
        }
        reload()
    }
    
    func reload() {
        locationManager.getUserLocation()
    }
    
}
