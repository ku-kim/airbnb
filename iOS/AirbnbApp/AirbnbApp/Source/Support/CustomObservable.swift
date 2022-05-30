//
//  CustomObservable.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/25.
//

import Foundation

final class PublishRelay<T> {
    typealias BindElement = (T) -> Void
    
    private var binders: [BindElement] = []
    
    func bind(onNext: @escaping BindElement) {
        binders.append(onNext)
    }
    
    func accept(_ value: T) {
        binders.forEach {
            $0(value)
        }
    }
}

final class BehaviorRelay<T> {
    typealias BindElement = (T) -> Void
    
    private var binders: [BindElement] = []
    private(set) var value: T
    
    init(value: T) {
        self.value = value
    }
    
    func bind(onNext: @escaping BindElement) {
        binders.append(onNext)
    }
    
    func accept(_ value: T) {
        self.value = value
        binders.forEach {
            $0(value)
        }
    }
}
