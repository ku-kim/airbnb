//
//  PriceRangeRepositoryImpl.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/02.
//

import Foundation

class PriceRangeRepositoryImpl: NetworkRepository<SearchHomeEndPoint>, PriceRangeRepository {
    
    func requestPriceRange(at coordinate: Coordinate,
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
    
    // TODO: Mock API가 아닌 실제 API 통신으로 리팩토링시 사용할 코드
//    func requestPriceRange(at coordinate: Coordinate,
//                           completion: @escaping (Result<PriceRangeEntity, NetworkError>) -> Void) {
//        networkManager.request(endPoint: .priceRange(coordinate: coordinate)) { response in
//            switch response {
//            case .success(let data):
//                if let decodedData = Self.decode(PriceRangeEntity.self, decodeTarget: data) {
//                    completion(.success(decodedData))
//                    print(decodedData)
//                } else {
//                    completion(.failure(.failToDecode))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
}
