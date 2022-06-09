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

    let loadedMinPrice = PublishRelay<Int>()
    let loadedMaxPrice = PublishRelay<Int>()
    
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
        
        loadMaxPrice.bind { [weak self] manRatio in
            self?.loadedMaxPrice.accept(Int(1000000 * manRatio)) // TODO: 상수 -> PriceRange의 Max값으로 변경
        }

        loadMinPrice.bind { [weak self] minRatio in
            self?.loadedMinPrice.accept(Int(1000000 * minRatio)) // TODO: 상수 -> PriceRange의 Max값으로 변경
        }
    }
    
}
