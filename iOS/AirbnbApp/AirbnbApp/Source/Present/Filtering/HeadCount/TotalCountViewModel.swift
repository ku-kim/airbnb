//
//  TotalCountViewModel.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/08.
//

import Foundation

final class TotalCountViewModel {
    
    var totalGuestCount = BehaviorRelay(value: 0)
    
    var loadAdultCount = BehaviorRelay(value: 0)
    var loadKidCount = BehaviorRelay(value: 0)
    var loadToddlerCount = BehaviorRelay(value: 0)
    
    init() {
        loadAdultCount.bind { [weak self] count in
            guard let self = self else { return }
            let totalCount = self.loadKidCount.value + count
            self.totalGuestCount.accept(totalCount)
        }
        
        loadKidCount.bind { [weak self] count in
            guard let self = self else { return }
            let totalCount = self.loadAdultCount.value + count
            self.totalGuestCount.accept(totalCount)
        }
        
        loadToddlerCount.bind { [weak self] count in
            // TODO: count를 이용해서 로직 완성
        }
        
        totalGuestCount.bind { [weak self] count in
            // TODO: count를 이용해서 로직 완성
            guard let totalCount = self?.totalGuestCount.value else { return }
        }
    }
    
}
