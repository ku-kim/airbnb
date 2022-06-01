//
//  SearchHomeCollectionViewDataSource.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/23.
//

import UIKit

protocol SearchHomeCellViewModelable { }

protocol SearhHomeCellable: UICollectionViewCell {
    func configureCell(with viewModel: SearchHomeCellViewModelable)
}

protocol SearchHomeSectionable {
    var count: Int { get }
    var header: String { get }
    
    var identifier: String { get }
    
    func getViewModel(indexPath: IndexPath) -> SearchHomeCellViewModelable
    
    func set(viewModels: [SearchHomeCellViewModelable])
}

class CityViewModel: SearchHomeSectionable {
    
    func getViewModel(indexPath: IndexPath) -> SearchHomeCellViewModelable {
        return viewModels[indexPath.item]
    }
    
    var identifier: String {
        return CityViewCell.identifier
    }
    
    var cellType: UICollectionViewCell.Type {
        return CityViewCell.self
    }
    
    private var viewModels: [SearchHomeCellViewModelable] = []
    
    func set(viewModels: [SearchHomeCellViewModelable]) {
        self.viewModels = viewModels
    }
    
    var count: Int {
        return viewModels.count
    }
    
    var header: String {
        return ""
    }
    
}

class BannerViewModel: SearchHomeSectionable {
    
    func getViewModel(indexPath: IndexPath) -> SearchHomeCellViewModelable {
        return viewModels[indexPath.item]
    }
    
    var identifier: String {
        return HeroBannerViewCell.identifier
    }
    
    var cellType: UICollectionViewCell.Type {
        return HeroBannerViewCell.self
    }
    
    private var viewModels: [SearchHomeCellViewModelable] = []
    
    func set(viewModels: [SearchHomeCellViewModelable]) {
        self.viewModels = viewModels
    }
    
    var count: Int {
        return viewModels.count
    }
    
    var header: String {
        return "가까운 여행지 둘러보기"
    }
}

class ThemeViewModel: SearchHomeSectionable {
    func getViewModel(indexPath: IndexPath) -> SearchHomeCellViewModelable {
        return viewModels[indexPath.item]
    }
    
    var identifier: String {
        return ThemeJourneyViewCell.identifier
    }
    
    var cellType: UICollectionViewCell.Type {
        return ThemeJourneyViewCell.self
    }
    
    var count: Int {
        return viewModels.count
    }
    
    var header: String {
        return "어디에서나, 여행은 살아보는거야!"
    }
    
    private var viewModels: [SearchHomeCellViewModelable] = []
    
    func set(viewModels: [SearchHomeCellViewModelable]) {
        self.viewModels = viewModels
    }
    
}

final class SearchHomeCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var sectionViewModelMap: [SearchHomeCollectionViewSection: SearchHomeSectionable] = [.nearCity: CityViewModel(),
                                                                                       .heroBanner: BannerViewModel(),
                                                                                       .themeJourney: ThemeViewModel()]
    
    @NetworkInject(keypath: \.imageManager)
    private var imageManager: ImageManager
    
    @NetworkInject(keypath: \.searchHomeRepositoryImplement)
    private var repository: SearchHomeRepositoryImpl
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionKind = SearchHomeCollectionViewSection(rawValue: section) else { return 0 }
        guard let count = sectionViewModelMap[sectionKind]?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionKind = SearchHomeCollectionViewSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
        guard let sectionViewModel = sectionViewModelMap[sectionKind],
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sectionViewModel.identifier,
                                                            for: indexPath) as? SearhHomeCellable else {
            return UICollectionViewCell()
        }
        
        let cellViewModel = sectionViewModel.getViewModel(indexPath: indexPath)
        cell.configureCell(with: cellViewModel)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionViewModelMap.count
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
    func set(sectionType: SearchHomeCollectionViewSection, viewModels: [SearchHomeCellViewModelable]) {
        sectionViewModelMap[sectionType]?.set(viewModels: viewModels)
    }
}
