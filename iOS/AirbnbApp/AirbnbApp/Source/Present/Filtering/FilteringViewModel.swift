//
//  FilteringViewModel.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/07.
//

import Foundation
import MapKit

class FilteringViewModel {
    
    let yearViewModel = YearViewModel()
    let priceRangeViewModel = PriceRangeViewModel()
    let headCountViewModel = HeadCountViewModel()
    
    lazy var conditionMap: [FilteringCondition: String] = [:]
    
    let location: MKLocalSearchCompletion
    
    let loadLoacationName = PublishRelay<Void>()
    let loadedLocationName = PublishRelay<String>()
    
    let updatedSchedule = PublishRelay<String>()
    let updatedPriceRange = PublishRelay<String>()
    let updatedTotalCount = PublishRelay<String>()
    
    init(location: MKLocalSearchCompletion) {
        self.location = location
        
        loadLoacationName.bind { [weak self] in
            self?.conditionMap[.location] = location.title
            self?.loadedLocationName.accept(location.title)
        }
        
        yearViewModel.updatedSchedule.bind { [weak self] date in
            guard let checkInDate = date.first,
                  let checkOutDate = date.last else { return }
            
            let checkInString = "\(checkInDate.month.getMonth())월 \(checkInDate.day.getDay())일"
            let checkOutString = "\(checkOutDate.month.getMonth())월 \(checkOutDate.day.getDay())일"
            
            let schedule = [checkInString, checkOutString].joined(separator: .Separator.schedule)
            
            self?.updatedSchedule.accept(schedule)
        }
        
        priceRangeViewModel.updatedPriceCondition.bind { [weak self] (min, max) in
            let formattedMinPrice = NumberFormatter.toPriceUnit(from: Int(min)) ?? ""
            let formattedMaxPrice = NumberFormatter.toPriceUnit(from: Int(max)) ?? ""
            let priceRange = "₩\(formattedMinPrice) - ₩\(formattedMaxPrice)+"
            
            self?.priceRangeViewModel.updatedMinPrice.accept(formattedMinPrice)
            self?.priceRangeViewModel.updatedMaxPrice.accept(formattedMaxPrice)
            self?.updatedPriceRange.accept(priceRange)
        }
        
        headCountViewModel.updatedTotalCount.bind { [weak self] totalCount in
            guard let totalCount = totalCount else { return }
            let totalAdult = totalCount[Age.adult.index]
            let totalKid = totalCount[Age.kid.index]
            let totalToddler = totalCount[Age.toddler.index]
            
            var guests = ["게스트 \(totalAdult + totalKid)명"]
            
            if totalToddler != 0 {
                guests.append("유아 \(totalToddler)명")
            }
            
            let guest = guests.joined(separator: .Separator.guest)
            self?.updatedTotalCount.accept(guest)
        }
    }
    
}
