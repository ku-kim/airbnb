//
//  ThemeSectionViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import Foundation

class ThemeSectionViewModel: SectionViewModelable {
    
    private var cellViewModels: [CellViewModelable] = []
    
    var identifier: String {
        return ThemeViewCell.identifier
    }
    
    var count: Int {
        return cellViewModels.count
    }
    
    var header: String {
        return .SearchHome.SectionHeader.theme
    }
    
    func getCellViewModel(at index: Int) -> CellViewModelable {
        return cellViewModels[index]
    }
    
    func configure(with cellViewModels: [CellViewModelable]) {
        self.cellViewModels = cellViewModels
    }
    
}
