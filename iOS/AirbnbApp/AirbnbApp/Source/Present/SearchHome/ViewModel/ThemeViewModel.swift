//
//  ThemeViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/30.
//

import Foundation

final class ThemeViewModel: ViewModelBindable {
    
    typealias actionType = Void
    typealias stateType = [String]
    
    private(set) var loadAction = PublishRelay<actionType>()
    private(set) var loadedState = PublishRelay<stateType>()
    
    let repository = SearchHomeRepositoryImpl() // TODO: 주입?
    
    init() {
        loadAction.bind(onNext: { [weak self] in
                self?.loadedState.accept(["자연생활을 만끽할 수 있는 숙소", "독특한 공간"])
            })
    }
}

// MARK: - Providing Function

extension ThemeViewModel {
    func accept(_ value: actionType) {
        loadAction.accept(value)
    }
    
    func bind(_ completion: @escaping (stateType) -> Void) {
        loadedState.bind(onNext: completion)
    }
}
