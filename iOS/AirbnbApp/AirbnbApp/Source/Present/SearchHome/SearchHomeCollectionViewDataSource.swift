//
//  SearchHomeCollectionViewDataSource.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/23.
//

import UIKit

protocol SearchHomeCellViewModel { }

protocol SearhHomeCellView: UICollectionViewCell {
    func setViewModel(_ viewModel: SearchHomeCellViewModel)
}

protocol SearchHomeProtocol {
    var count: Int { get }
    var header: String { get }
    
    var identifier: String { get }
    
    func getViewModel(indexPath: IndexPath) -> SearchHomeCellViewModel
    
    func set(viewModels: [SearchHomeCellViewModel])
}

class CityViewModel: SearchHomeProtocol {
    
    func getViewModel(indexPath: IndexPath) -> SearchHomeCellViewModel {
        return viewModels[indexPath.item]
    }
    
    var identifier: String {
        return CityViewCell.identifier
    }
    
    var cellType: UICollectionViewCell.Type {
        return CityViewCell.self
    }
    
    private var viewModels: [SearchHomeCellViewModel] = []
    
    func set(viewModels: [SearchHomeCellViewModel]) {
        self.viewModels = viewModels
    }
    
    var count: Int {
        return viewModels.count
    }
    
    var header: String {
        return ""
    }
    
}

class BannerViewModel: SearchHomeProtocol {
    
    func getViewModel(indexPath: IndexPath) -> SearchHomeCellViewModel {
        return viewModels[indexPath.item]
    }
    
    var identifier: String {
        return HeroBannerViewCell.identifier
    }
    
    var cellType: UICollectionViewCell.Type {
        return HeroBannerViewCell.self
    }
    
    private var viewModels: [SearchHomeCellViewModel] = []
    
    func set(viewModels: [SearchHomeCellViewModel]) {
        self.viewModels = viewModels
    }
    
    var count: Int {
        return viewModels.count
    }
    
    var header: String {
        return "가까운 여행지 둘러보기"
    }
}

class ThemeViewModel: SearchHomeProtocol {
    func getViewModel(indexPath: IndexPath) -> SearchHomeCellViewModel {
        return viewModels[indexPath.item]
    }
    
    var identifier: String {
        return ThemeJourneyViewCell.identifier
    }
    
    var cellType: UICollectionViewCell.Type {
        return ThemeJourneyViewCell.self
    }
    
    private var viewModels: [SearchHomeCellViewModel] = []
    
    func set(viewModels: [SearchHomeCellViewModel]) {
        self.viewModels = viewModels
    }
    
    var count: Int {
        return viewModels.count
    }
    
    var header: String {
        return "어디에서나, 여행은 살아보는거야!"
    }
}




final class SearchHomeCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var viewModelMap: [SearchHomeCollectionViewSection: SearchHomeProtocol] = [.nearCity: CityViewModel(),
                                                                                       .heroBanner: BannerViewModel(),
                                                                                       .themeJourney: ThemeViewModel()]
    
    @NetworkInject(keypath: \.imageManager)
    private var imageManager: ImageManager
    
    @NetworkInject(keypath: \.searchHomeRepositoryImplement)
    private var repository: SearchHomeRepositoryImpl
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionKind = SearchHomeCollectionViewSection(rawValue: section) else { return 0 }
        guard let count = viewModelMap[sectionKind]?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionKind = SearchHomeCollectionViewSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
        
        
        guard let dataSource = viewModelMap[sectionKind],
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dataSource.identifier,
                                                            for: indexPath) as? SearhHomeCellView else {
            return UICollectionViewCell()
        }
        
        let viewModel = dataSource.getViewModel(indexPath: indexPath)
        cell.setViewModel(viewModel)
        
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SearchHomeCollectionViewSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SearchHomeHeaderView.identifier,
                for: indexPath
            ) as? SearchHomeHeaderView else { return UICollectionReusableView() }
            
            headerView.setHeaderLabel(text: SearchHomeCollectionViewSection.allCases[indexPath.section].header)
            return headerView
        }
        
        return UICollectionReusableView()
    }
}

// MARK: - Providing Function

extension SearchHomeCollectionViewDataSource {
    func set(viewModels: [SearchHomeCellViewModel], sectionType: SearchHomeCollectionViewSection) {
        viewModelMap[sectionType]?.set(viewModels: viewModels)
    }
}
