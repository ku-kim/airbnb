//
//  BannerSectionViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import Foundation

class BannerSectionViewModel: SectionViewModelable {
    
    private var cellViewModels: [CellViewModelable] = []
    
    var identifier: String {
        return BannerViewCell.identifier
    }
    
    var count: Int {
        return cellViewModels.count
    }
    
    var header: String {
        return ""
    }
    
    func getCellViewModel(at index: Int) -> CellViewModelable {
        return cellViewModels[index]
    }
    
    func configure(with cellViewModels: [CellViewModelable]) {
        self.cellViewModels = cellViewModels
    }
}
