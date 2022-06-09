//
//  FilteringViewModel.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/07.
//

import Foundation
import MapKit

class FilteringViewModel {
    
    let totalHeadCountViewModel = HeadCountViewModel()
    
    let updatedTotalHeadCount = PublishRelay<Int>()
    //4가지 조건 다 채워지면 '다음'버튼 활성화
    //다음버튼이 눌러지면, 4가지 조건을 서버로 보내서, 받아온 정보에 대한 ViewModel을 만들어서 다음 VC를 Push
    
    let location: MKLocalSearchCompletion
    
    let loadLoacationName = PublishRelay<Void>()
    let loadedLocationName = PublishRelay<String>()
    
    init(location: MKLocalSearchCompletion) {
        self.location = location
        
        loadLoacationName.bind { [weak self] in
            self?.loadedLocationName.accept(location.title)
        }
        
        totalHeadCountViewModel.updatedTotalCount.bind { [weak self] value in
            self?.updatedTotalHeadCount.accept(value)
        }
    }
    
}
