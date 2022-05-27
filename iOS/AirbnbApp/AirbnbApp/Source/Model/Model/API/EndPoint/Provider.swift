//
//  Provider.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Alamofire
import Foundation

class Provider<EndPoint: EndPointable> {
    
    static func foo(endPoint: EndPoint) {
        guard let url = endPoint.fullUrl else { return }
        AF.request(url,
                   method: endPoint.method,
                   parameters: endPoint.parameter)
        .responseDecodable(of: SearchHomeEntity.self) { response in
            switch response.result {
            // TODO: success, failure handling
            case .success(let result):
                print(result.data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
