//
//  SearchHomeViewModelState.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation

protocol SearchHomeViewModelState {
    var loadedHeader: PublishRelay<[String]> { get }
    var loadedImage: PublishRelay<String> { get }
    var loadedCityName: PublishRelay<[String]> { get }
    var loadedTheme: PublishRelay<[String]> { get }
    
    func bindHeader(completion: @escaping ([String]) -> Void)
    func bindImage(completion: @escaping (String) -> Void)
    func bindCityName(completion: @escaping ([String]) -> Void)
    func bindTheme(completion: @escaping ([String]) -> Void)
}
