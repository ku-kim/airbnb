//
//  SearchHomeViewModelState.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation

protocol ViewModelState {
    var loadedState: PublishRelay<[CellViewModelable]> { get }
}
