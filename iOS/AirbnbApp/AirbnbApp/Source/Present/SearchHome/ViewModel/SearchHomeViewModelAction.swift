//
//  SearchHomeViewModelAction.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation

protocol SearchHomeViewModelAction {
    var loadHeader: PublishRelay<Void> { get }
    var loadNearCities: PublishRelay<Void> { get }
    var loadHeroBanner: PublishRelay<Void> { get }
    var loadTheme: PublishRelay<Void> { get }
}
