//
//  Provider.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Alamofire
import Foundation

class Provider<EndPoint: EndPointable> {
    
    private static func createRequest(_ endPoint: EndPointable) -> URLRequest? {
        guard let baseUrl = endPoint.baseURL else { return nil }
        var url = baseUrl
        
        if let path = endPoint.path {
            url.appendPathComponent(path)
        }
        
        if let parameter = endPoint.parameter {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)

            let queryItems = parameter.map {
                URLQueryItem(name: $0.key, value: $0.value as? String)
            }
            
            components?.queryItems = queryItems

            guard let componentsUrl = components?.url else { return nil }
            url = componentsUrl
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endPoint.method.value
        endPoint.header?.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
}
