//
//  FilteringCondition.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/07.
//

import Foundation

enum FilteringCondition: CaseIterable {
    case location
    case checkInAndOut
    case fee
    case headCount
    
    var title: String {
        switch self {
        case .location:
            return .FilteringCondition.location
        case .checkInAndOut:
            return .FilteringCondition.checkInAndOut
        case .fee:
            return .FilteringCondition.fee
        case .headCount:
            return .FilteringCondition.headCount
        }
    }
    
    static var count: Int {
        return Self.allCases.count
    }
}
