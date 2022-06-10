//
//  PriceRangeRepositoryImpl.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/02.
//

import Foundation

class PriceRangeRepositoryImpl: NetworkRepository<SearchHomeEndPoint>, PriceRangeRepository {
    
    func requestPriceRange(from resource: String, with extension: String,
                           completion: @escaping (Result<PriceRangeEntity, NetworkError>) -> Void) {
        guard let url = Bundle.main.url(forResource: "PriceRangeMockAPI", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        if let decodedData = Self.decode(PriceRangeEntity.self, decodeTarget: data) {
            completion(.success(decodedData))
        } else {
            completion(.failure(.failToDecode))
        }
    }
    
    func requestPriceRange(at coordinate: Coordinate,
                           completion: @escaping (Result<PriceRangeEntity, NetworkError>) -> Void) {
        
        networkManager.request(endPoint: .priceRange(coordinate: coordinate)) { response in
            switch response {
            case .success(let data):
                if let decodedData = Self.decode(PriceRangeEntity.self, decodeTarget: data) {
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
