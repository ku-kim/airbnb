//
//  Provider.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Alamofire
import Foundation

class NetworkManager<Target: Requestable> {
    
    func request(endPoint: Target, completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        
        guard let url = endPoint.fullUrl else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let request: DataRequest = AF.request(url,
                                              method: endPoint.method,
                                              parameters: endPoint.parameter)
        request
            .validate(statusCode: 200..<300)
            .response { response in
                if let data = response.data {
                    completion(.success(data))
                } else {
                    completion(.failure(.emptyData))
                }
            }
    }
    
}
