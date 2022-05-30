//
//  NetworkRepository.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/29.
//

import Foundation

class NetworkRepository<Target: Requestable> {
    let networkManager = NetworkManager<Target>()
    
    static func decode<T: Decodable>(_ type: T.Type, decodeTarget data: Data?) -> T? {
        guard let data = data,
              let decodedData = try? JSONDecoder().decode(type.self, from: data) else {
            return nil
        }
        return decodedData
    }
}
