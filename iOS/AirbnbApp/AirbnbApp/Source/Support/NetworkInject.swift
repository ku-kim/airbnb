//
//  NetworkInject.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/31.
//

import Foundation

@propertyWrapper
struct NetworkInject<T> {
    var wrappedValue: T
    
    init(keypath: KeyPath<NetworkContainer, T>) {
        let container = NetworkContainer.shared
        wrappedValue = container[keyPath: keypath]
    }
}
