//
//  SearchHomeViewModelBindable.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation

protocol SearchHomeViewModelBindable: SearchHomeViewModelAction & SearchHomeViewModelState {
    func action() -> SearchHomeViewModelAction
    func state() -> SearchHomeViewModelState
}
