//
//  CitySectionViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import Foundation

class CitySectionViewModel: SectionViewModelable {
    
    private var cellViewModels: [CellViewModelable] =  []
    
    var identifier: String {
        return CityViewCell.identifier
    }
    
    var count: Int {
        return cellViewModels.count
    }
    
    var header: String {
        return "가까운 여행지 둘러보기"
    }
    
    func getCellViewModel(at index: Int) -> CellViewModelable {
        return cellViewModels[index]
    }
    
    func configure(with cellViewModels: [CellViewModelable]) {
        self.cellViewModels = cellViewModels
    }
    
}
