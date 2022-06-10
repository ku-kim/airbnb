//
//  HeadCountItemViewModel.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/09.
//

import Foundation

final class HeadCountItemViewModel {
    
    let loadContent = PublishRelay<Void>()
    let loadedTitle = PublishRelay<String>()
    let loadedDescription = PublishRelay<String>()
    
    let tappedAddButton = PublishRelay<Int>()
    let changeGuestCount = PublishRelay<(Age, Int)>()
    
    let updateCount = PublishRelay<Int>()
    let enablePlusButton = PublishRelay<Bool>()
    
    private let age: Age
    
    init(age: Age) {
        self.age = age
        
        loadContent.bind { [weak self] in
            self?.loadedTitle.accept(age.title)
            self?.loadedDescription.accept(age.description)
            self?.updateCount.accept(0)
        }
        
        tappedAddButton.bind { [weak self] value in
            self?.changeGuestCount.accept((age, value))
        }
    }
    
}
