//
//  FilteringViewModel.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/07.
//

import Foundation
import MapKit

class FilteringViewModel {
    
    let location: MKLocalSearchCompletion
    
    let loadLoacationName = PublishRelay<Void>()
    let loadedLocationName = PublishRelay<String>()
    
    init(location: MKLocalSearchCompletion) {
        self.location = location
        
        loadLoacationName.bind { [weak self] in
            self?.loadedLocationName.accept(location.title)
        }
    }
    
}
