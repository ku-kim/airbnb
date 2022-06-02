//
//  PopularSectionViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import Foundation

class PopularSectionViewModel: SectionViewModelable {
    
    private var cellViewModels: [CellViewModelable] =  []
    
    var identifier: String {
        return CityViewCell.identifier
    }
    
    var count: Int {
        return cellViewModels.count
    }
    
    var header: String {
        return "근처의 인기 여행지"
    }
    
    func getCellViewModel(at index: Int) -> CellViewModelable {
        return cellViewModels[index]
    }
    
    func configure(with cellViewModels: [CellViewModelable]) {
        self.cellViewModels = cellViewModels
    }
    
}
