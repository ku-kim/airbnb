//
//  SearchHomeRepositoryImpl.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/29.
//

import Foundation

class SearchHomeRepositoryImpl: NetworkRepository<SearchHomeEndPoint>, SearchHomeRepository {
    
    func requestNearDestination(coordinate: Coordinate,
                                completion: @escaping (Result<SearchHomeEntity.NearCity, NetworkError>) -> Void) {
        networkManager.request(endPoint: .nearDestination(coordinate: coordinate)) { response in
            switch response {
            case .success(let data):
                if let decodedData = Self.decode(SearchHomeEntity.NearCity.self, decodeTarget: data) {
                    completion(.success(decodedData))
                } else {
                    completion(.failure(.failToDecode))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestHeroBanner(completion: @escaping (Result<SearchHomeEntity.HeroBanner, NetworkError>) -> Void) {
        networkManager.request(endPoint: .heroBanner) { response in
            switch response {
            case .success(let data):
                if let decodedData = Self.decode(SearchHomeEntity.HeroBanner.self, decodeTarget: data) {
                    completion(.success(decodedData))
                } else {
                    completion(.failure(.failToDecode))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestTheme(completion: @escaping (Result< SearchHomeEntity.ThemeJourney, NetworkError>) -> Void) {
        networkManager.request(endPoint: .themeJourney) { response in
            switch response {
            case .success(let data):
                if let decodedData = Self.decode(SearchHomeEntity.ThemeJourney.self, decodeTarget: data) {
                    completion(.success(decodedData))
                } else {
                    completion(.failure(.failToDecode))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}
