//
//  EndPointable.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation
import Alamofire

protocol EndPointable {
    var baseUrl: URL? { get }
    var path: String? { get }
    var fullUrl: Alamofire.URLConvertible? { get }
    var parameter: Alamofire.Parameters? { get }
    var method: Alamofire.HTTPMethod { get }

}
