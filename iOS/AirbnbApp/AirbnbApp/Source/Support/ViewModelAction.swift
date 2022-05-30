//
//  ViewModelAction.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation

protocol ViewModelAction {
    associatedtype actionType
    var loadAction: PublishRelay<actionType> { get }
}
