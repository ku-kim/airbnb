//
//  SearchHomeViewModelAction.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation

protocol SearchHomeViewModelAction {
    var loadHeader: PublishRelay<Void> { get }
    var loadImage: PublishRelay<Void> { get }
    var loadCityName: PublishRelay<Void> { get }
    var loadTheme: PublishRelay<Void> { get }
    
    func acceptHeader(value: Void)
    func acceptImage(value: Void)
    func acceptCityName(value: Void)
    func acceptTheme(value: Void)
}
