//
//  SearchHomeViewModel.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/25.
//

import Foundation

final class SearchHomeViewModel {
    
    private var sectionViewModelMap: [SearchHomeCollectionViewSection: ViewModelBindable] = [.nearCity: CityViewModel(),
                                                                                             .banner: BannerViewModel(),
                                                                                             .theme: ThemeViewModel()]
}

// MARK: - Providing Function

extension SearchHomeViewModel {
    
    func accept(sectionType: SearchHomeCollectionViewSection, value: Void) {
        sectionViewModelMap[sectionType]?.accept(value)
    }
    
    func bind(sectionType: SearchHomeCollectionViewSection, completion: @escaping ([CellViewModelable]) -> Void) {
        sectionViewModelMap[sectionType]?.bind(completion)
    }
    
    func reload() {
        guard let viewModel = sectionViewModelMap[.nearCity] as? CityViewModel else { return }
        viewModel.reload()
    }
    
}
