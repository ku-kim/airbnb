//
//  ViewModelBindable.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation

protocol ViewModelBindable: ViewModelAction, ViewModelState {
    func accept(_ value: actionType)
    func bind(_ completion: @escaping (stateType) -> Void)
}
