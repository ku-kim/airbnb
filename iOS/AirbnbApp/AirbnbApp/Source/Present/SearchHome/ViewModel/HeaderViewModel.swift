//
//  HeaderViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/30.
//

import Foundation

final class HeaderViewModel: ViewModelBindable {
    typealias actionType = Void
    typealias stateType = [String]
    
    private(set) var loadAction =  PublishRelay<actionType>()
    private(set) var loadedState = PublishRelay<stateType>()

    let repository = SearchHomeRepositoryImpl() // TODO: 주입?
    
    init() {
        loadAction.bind(onNext: {[weak self] in
            self?.loadedState.accept(["", "가까운 여행지 둘러보기", "어디에서나, 여행은 살아보는거야!"])
        })
    }
}

// MARK: - Providing Function

extension HeaderViewModel {
    
    func accept(_ value: actionType) {
        loadAction.accept(value)
    }
            
    func bind(_ completion: @escaping (stateType) -> Void) {
        loadedState.bind(onNext: completion)
    }
    
}
