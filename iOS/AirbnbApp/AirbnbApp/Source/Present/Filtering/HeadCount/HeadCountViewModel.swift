//
//  HeadCountViewModel.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/09.
//

import Foundation

class HeadCountViewModel {
    
    var currentCount = Age.allCases.map { _ in 0 }
    
    let loadItemViewModel = PublishRelay<Void>()
    let loadedItemViewModels = PublishRelay<[HeadCountItemViewModel]>()
    let itemViewModels: [HeadCountItemViewModel] = Age.allCases.map { HeadCountItemViewModel(age: $0) }
    
    let updatedTotalCount = PublishRelay<[Int]?>()
    
    init() {
        loadItemViewModel.bind { [weak self] in
            self?.loadedItemViewModels.accept(self?.itemViewModels ?? [] )
        }
        
        itemViewModels.forEach { viewModel in
            viewModel.changeGuestCount.bind { [weak self] (age, value) in
                
                var totalCount = self?.currentCount.reduce(0, +) ?? 0
                
                if value > 0, totalCount >= Int.HeadCount.maxGuestCount { return }
                
                self?.currentCount[age.index] += value
                
                totalCount = self?.currentCount.reduce(0, +) ?? 0
                
                self?.itemViewModels.forEach { viewModel in
                    viewModel.enablePlusButton.accept(totalCount < Int.HeadCount.maxGuestCount)
                }
                
                if (age == .toddler || age == .kid) && self?.currentCount[Age.adult.index] == 0 && value != -1 {
                    totalCount += 1
                    self?.currentCount[Age.adult.index] += 1
                    self?.itemViewModels[Age.adult.index].updateCount.accept(1)
                }
                
                self?.itemViewModels[age.index].updateCount.accept(self?.currentCount[age.index] ?? 0)
                
                self?.updatedTotalCount.accept(self?.currentCount)
            }
        }
    }
    
}
