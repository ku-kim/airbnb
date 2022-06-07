//
//  PriceRangeViewModel.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/02.
//

import Foundation

class PriceRangeViewModel {
    
    let loadAction = PublishRelay<Void>()
    let loadedState = PublishRelay<PriceRange>()
    
    @NetworkInject(keypath: \.priceRangeRepository)
    private var repository: PriceRangeRepository
    
    init() {
        loadAction.bind(onNext: { [weak self] in
            //TODO: (가능하다면) Coordinate를 사용자의 현재 위경도로 사용하기
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
    }
    
}