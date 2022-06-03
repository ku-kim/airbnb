//
//  CityCellViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import Foundation

class CityCellViewModel: CellViewModelable {
    
    let loadCityData = PublishRelay<Void>()
    let loadedCityName = PublishRelay<String>()
    let loadedCityImage = PublishRelay<String>()
    let loadedTime = PublishRelay<Int>()
    
    init(city: SearchHomeEntity.City) {
        self.loadCityData.bind { [ weak self ] in
            self?.loadedCityName.accept(city.cityName)
            self?.loadedCityImage.accept(city.imageUrl)
            self?.loadedTime.accept(city.time)
        }
    }
    
    func disposeBind() {
        loadedCityName.clearBinds()
        loadedCityImage.clearBinds()
        loadedTime.clearBinds()
    }
    
}
