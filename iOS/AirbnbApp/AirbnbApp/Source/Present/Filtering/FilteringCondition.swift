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
            return "위치"
        case .checkInAndOut:
            return "체크인/체크아웃"
        case .fee:
            return "요금"
        case .headCount:
            return "인원"
        }
    }
    
    static var count: Int {
        return Self.allCases.count
    }
}
