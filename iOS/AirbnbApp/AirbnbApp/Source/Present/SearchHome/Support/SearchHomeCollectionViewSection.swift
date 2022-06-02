//
//  SearchHomeCollectionViewSection.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/24.
//

import Foundation

enum SearchHomeCollectionViewSection: Int, CaseIterable {
    case banner, nearCity, theme
    
    var indexSet: IndexSet {
        return IndexSet(integer: rawValue)
    }
}
