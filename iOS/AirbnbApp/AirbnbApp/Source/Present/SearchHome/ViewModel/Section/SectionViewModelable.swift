//
//  SectionViewModelable.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import Foundation

protocol SectionViewModelable {
    var identifier: String { get }
    var header: String { get }
    var count: Int { get }
    
    func getCellViewModel(at index: Int) -> CellViewModelable
    func configure(with cellViewModels: [CellViewModelable])
}
