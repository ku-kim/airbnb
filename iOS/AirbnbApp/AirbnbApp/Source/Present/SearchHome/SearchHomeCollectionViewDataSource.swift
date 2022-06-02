//
//  SearchHomeCollectionViewDataSource.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/23.
//

import UIKit

final class SearchHomeCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var sectionViewModelMap: [SearchHomeCollectionViewSection: SectionViewModelable] = [.nearCity: CitySectionViewModel(),
                                                                                                .banner: BannerSectionViewModel(),
                                                                                                .theme: ThemeSectionViewModel()]
    
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
                                                            for: indexPath) as? ViewCellBindable else {
            return UICollectionViewCell()
        }
        
        let cellViewModel = sectionViewModel.getCellViewModel(at: indexPath.item)
        cell.configure(with: cellViewModel)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionViewModelMap.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionKind = SearchHomeCollectionViewSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        guard kind == UICollectionView.elementKindSectionHeader,
              let sectionViewModel = sectionViewModelMap[sectionKind],
              let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SearchHomeHeaderView.identifier,
                for: indexPath
              ) as? SearchHomeHeaderView else { return UICollectionReusableView() }
        
        let header = sectionViewModel.header
        headerView.setHeaderLabel(text: header)
        
        return headerView
    }
}

// MARK: - Providing Function

extension SearchHomeCollectionViewDataSource {
    func configure(sectionType: SearchHomeCollectionViewSection, with viewModels: [CellViewModelable]) {
        sectionViewModelMap[sectionType]?.configure(with: viewModels)
    }
}
