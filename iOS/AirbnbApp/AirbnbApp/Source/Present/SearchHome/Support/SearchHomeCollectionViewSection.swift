//
//  SearchHomeCollectionViewSection.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/24.
//

import Foundation

enum SearchHomeCollectionViewSection: Int, CaseIterable {
    case heroBanner, nearCity, themeJourney
    
    var header: String {
        switch self {
        case .heroBanner:
            return ""
        case .nearCity:
            return "가까운 여행지 둘러보기"
        case .themeJourney:
            return "어디에서나, 여행은 살아보는거야!"
        }
    }
}
