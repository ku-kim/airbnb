//
//  ViewModelBindable.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation

protocol ViewModelBindable: ViewModelAction, ViewModelState {
    func accept(_ value: Void)
    func bind(_ completion: @escaping ([CellViewModelable]) -> Void)
}

extension ViewModelBindable {
    
    func accept(_ value: Void) {
        loadAction.accept(value)
    }
    
    func bind(_ completion: @escaping ([CellViewModelable]) -> Void) {
        loadedState.bind(onNext: completion)
    }
}
