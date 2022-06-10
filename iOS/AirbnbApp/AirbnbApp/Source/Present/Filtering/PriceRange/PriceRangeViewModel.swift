//
//  PriceRangeViewModel.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/02.
//

import Foundation

class PriceRangeViewModel {
    
    let loadAction = PublishRelay<Void>()
    let loadedState = PublishRelay<PriceRangeEntity.PriceRange>()
    
    let loadMinPrice = PublishRelay<Double>()
    let loadMaxPrice = PublishRelay<Double>()
    let loadPriceRange = PublishRelay<(Double, Double)>()
    
    let loadedMinPrice = PublishRelay<String>()
    let loadedMaxPrice = PublishRelay<String>()
    
    let loadedPriceRange = PublishRelay<(min: Double, max: Double)>()
    
    @NetworkInject(keypath: \.priceRangeRepository)
    private var repository: PriceRangeRepository
    
    init() {
        loadAction.bind(onNext: { [weak self] in
            self?.repository.requestPriceRange(at: Coordinate(lat: 37.5, lng: 127.1)) { result in
                switch result {
                case .success(let priceRangeEntity):
                    let priceRange = priceRangeEntity.priceRange
                    self?.loadedState.accept(priceRange)
                case .failure(let error):
                    print(error.localizedDescription) // TODO: Error 처리
                }
            }
        })
        
        loadPriceRange.bind { [weak self] min, max in
//            let numberFormatter = NumberFormatter()
//            numberFormatter.numberStyle = .decimal
//            let formattedMinPrice = numberFormatter.string(from: NSNumber(value: Int(1000000 * min))) ?? ""
//            let formattedMaxPrice = numberFormatter.string(from: NSNumber(value: Int(1000000 * max))) ?? ""
//            self?.loadedMinPrice.accept(formattedMinPrice)
//            self?.loadedMaxPrice.accept(formattedMaxPrice)
            
            self?.loadedPriceRange.accept((1000000 * min, 1000000 * max))
        }
        
        
    }
    
}
