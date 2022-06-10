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
    
    let selectedDateRange = PublishRelay<[(MonthViewModel, DayViewModel)]>()
    let selectedHeadCount = PublishRelay<Int>()
    
    
    
    let inputCondition = PublishRelay<(FilteringCondition, String)>()
    
    var conditionMap: [FilteringCondition: String?] = FilteringCondition.allCases.reduce(into: [FilteringCondition: String]()) {
        $0[$1] = nil
    }
    
    let outputCondition = PublishRelay<(FilteringCondition, String)>()
    
    let updatedTotalHeadCount = PublishRelay<Int>()
    let isEnableNextButton = PublishRelay<Bool>()
    
    
    //4가지 조건 다 채워지면 '다음'버튼 활성화
    //다음버튼이 눌러지면, 4가지 조건을 서버로 보내서, 받아온 정보에 대한 ViewModel을 만들어서 다음 VC를 Push
    
    let location: MKLocalSearchCompletion
    //    let 일정:
    //    let 가격:
    //    let 인원:
    //
    
    
    
    let findFiltered숙소 = PublishRelay<Void>()
    
    
    let loadLoacationName = PublishRelay<Void>()
    let loadedLocationName = PublishRelay<String>()
    
    init(location: MKLocalSearchCompletion) {
        self.location = location
        conditionMap[.location] = location.title
        
        loadLoacationName.bind { [weak self] in
            self?.loadedLocationName.accept(location.title)
        }
        
//        headCountViewModel.updatedTotalCount.bind { [weak self] value in
////            print(value)
////            self?.updatedTotalHeadCount.accept(value)
//        }
        
        inputCondition.bind { [weak self] (filteringCondition, str) in
            self?.conditionMap.updateValue(str, forKey: filteringCondition)
            self?.outputCondition.accept((filteringCondition, str))
        }
        
        inputCondition.bind { [weak self] (_, _) in
            var isEnable = false
            
            if self?.conditionMap.count == FilteringCondition.allCases.count {
                isEnable = true
            }
            
            self?.isEnableNextButton.accept(isEnable)
        }
        
        yearViewModel.updatedRange.bind { range in
            
            print(range[0].0.getYear())
            print(range[0].0.getMonth())
            print(range[0].1.getDay())

            print(range[1].0.getYear())
            print(range[1].0.getMonth())
            print(range[1].1.getDay())
        }
        
        priceRangeViewModel.loadedPriceRange.bind { range in
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let formattedMinPrice = numberFormatter.string(from: NSNumber(value: Int(range.min))) ?? ""
            let formattedMaxPrice = numberFormatter.string(from: NSNumber(value: Int(range.max))) ?? ""
            print("₩\(formattedMinPrice) - ₩\(formattedMaxPrice)+")
        }
        
        headCountViewModel.updatedTotalCount.bind { totalCount in
            guard let totalCount = totalCount else { return }
            let totalAdult = totalCount[Age.adult.index]
            let totalKid = totalCount[Age.kid.index]
            let totalToddler = totalCount[Age.toddler.index]
            
            if totalToddler == 0 {
                print("게스트 \(totalAdult + totalKid)명")
            } else {
                print("게스트 \(totalAdult + totalKid)명 유아 \(totalToddler)명")
            }
        }
    }
    
}
