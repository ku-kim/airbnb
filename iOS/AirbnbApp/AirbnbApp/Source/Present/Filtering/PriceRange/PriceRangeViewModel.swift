//
//  PriceRangeViewModel.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/02.
//

import Foundation
import CoreGraphics

class PriceRangeViewModel {
    
    let loadAction = PublishRelay<Void>()
    let loadedState = PublishRelay<PriceRangeEntity.PriceRange>()
    
    let loadMinPrice = PublishRelay<Double>()
    let loadMaxPrice = PublishRelay<Double>()
    
    let loadedMinPrice = PublishRelay<String>()
    let loadedMaxPrice = PublishRelay<String>()
    let loadedAveragePrice = PublishRelay<String>()
    let loadedHistogramViewPoints = PublishRelay<[CGPoint]>()
    
    let slideAdjusted = PublishRelay<(Double, Double)>()
    let updatedPriceCondition = PublishRelay<(min: Double, max: Double)>()
    
    let updatedMinPrice = PublishRelay<String>()
    let updatedMaxPrice = PublishRelay<String>()
    
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
        
        loadedState.bind { [weak self] priceEntity in
            guard let minPrice = priceEntity.histogram.first?.min,
                  let maxPrice = priceEntity.histogram.last?.min else { return }
            
            let formattedAveragePrice = NumberFormatter.toPriceUnit(from: Int(priceEntity.averagePrice)) ?? ""
            let formattedMinPrice = NumberFormatter.toPriceUnit(from: minPrice) ?? ""
            let formattedMaxPrice = NumberFormatter.toPriceUnit(from: maxPrice) ?? ""
            
            self?.loadedMinPrice.accept(formattedMinPrice)
            self?.loadedMaxPrice.accept(formattedMaxPrice)
            self?.loadedAveragePrice.accept(formattedAveragePrice)
        }
        
        loadedState.bind { [weak self] priceEntity in
            guard let max = priceEntity.histogram.max() else { return }
            let maxCount = max.count
            var points: [CGPoint] = []
            let count = priceEntity.histogram.count
            
            priceEntity.histogram.enumerated().forEach { index, histogram in
                let point = CGPoint(x: CGFloat(index) / CGFloat(count), y: CGFloat(histogram.count) / CGFloat(maxCount))
                points.append(point)
            }
            
            self?.loadedHistogramViewPoints.accept(points)
        }
        
        slideAdjusted.bind { [weak self] (min, max) in
            self?.updatedPriceCondition.accept((Double.maxPriceOffset * min, Double.maxPriceOffset * max))
        }
    }
    
}
