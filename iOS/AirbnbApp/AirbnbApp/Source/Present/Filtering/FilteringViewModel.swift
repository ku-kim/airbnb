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
    
//    var conditionMap: [FilteringCondition: String?] = FilteringCondition.allCases.reduce(into: [FilteringCondition: String]()) {
//        $0[$1] = nil
//    }
    
    let enableButton = PublishRelay<Bool>()
    
    lazy var conditionMap: [FilteringCondition: String] = [:] {
        didSet {
            if conditionMap.count == FilteringCondition.count {
                enableButton.accept(true)
            }
        }
    }
    
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
            let checkInDate = date[0]
            let checkOutDate = date[1]
            
            let checkInString = "\(checkInDate.month.getMonth())월 \(checkInDate.day.getDay())일"
            let checkOutString = "\(checkOutDate.month.getMonth())월 \(checkOutDate.day.getDay())일"
            
            let schedule = [checkInString, checkOutString].joined(separator: " - ")
            
            self?.conditionMap.updateValue(schedule, forKey: .checkInAndOut)
            self?.updatedSchedule.accept(schedule)
        }
        
        priceRangeViewModel.updatedPriceRange.bind { [weak self] range in
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let formattedMinPrice = numberFormatter.string(from: NSNumber(value: Int(range.min))) ?? ""
            let formattedMaxPrice = numberFormatter.string(from: NSNumber(value: Int(range.max))) ?? ""
            let priceRange = "₩\(formattedMinPrice) - ₩\(formattedMaxPrice)+"
            
            self?.conditionMap.updateValue(priceRange, forKey: .priceRange)
            self?.updatedPriceRange.accept(priceRange)
            
            self?.priceRangeViewModel.labelMin.accept(formattedMinPrice)
            self?.priceRangeViewModel.labelMax.accept(formattedMaxPrice)
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
            
            let guest = guests.joined(separator: ", ")
//            self?.conditionMap.updateValue((totalAdult, totalKid, totalToddler), forKey: .headCount)
            self?.updatedTotalCount.accept(guest)
        }
    }
    
}
