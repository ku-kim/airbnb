//
//  PopularCollectionViewDataSource.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/29.
//

import UIKit

final class PopularCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var sectionViewModel: SectionViewModelable = CitySectionViewModel()
    
    let imageManager = NetworkContainer.shared.imageManager
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityViewCell.identifier, for: indexPath) as? CityViewCell else {
            return UICollectionViewCell()
        }
        let cellViewModel = sectionViewModel.getCellViewModel(at: indexPath.item)
        cell.configure(with: cellViewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: PopularHeaderView.identifier,
                for: indexPath
              ) as? PopularHeaderView else { return UICollectionReusableView() }
        
        let header = sectionViewModel.header
        headerView.setHeaderLabel(text: header)
        
        return headerView
    }
    
}

// MARK: - Providing Function

extension PopularCollectionViewDataSource {
    func configure(with cellViewModels: [CellViewModelable]) {
        self.sectionViewModel.configure(with: cellViewModels)
    }
}
