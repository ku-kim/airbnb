//
//  PopularCollectionViewDataSource.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/29.
//

import UIKit

final class PopularCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var nearCities: [SearchHomeEntity.City] = []
    
    let imageManager = NetworkContainer.shared.imageManager
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearCities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityViewCell.identifier, for: indexPath) as? CityViewCell else {
            return UICollectionViewCell()
        }
        let item = nearCities[indexPath.item]
        
        let imageUrl = URL(string: item.imageUrl)
        imageManager.fetchImage(from: imageUrl) { image in
            DispatchQueue.main.async {
                cell.setCityImageView(image: image ?? UIImage())
                // TODO: image가 nil일 경우 handling하는 에러 구현하기
            }
        }
        cell.setCityTitleLabel(text: item.cityName)
        cell.setDistanceLabel(text: item.time.convertIntoTime())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: PopularHeaderView.identifier,
                for: indexPath
            ) as? PopularHeaderView else { return UICollectionReusableView() }
            
            headerView.setHeaderLabel(text: "근처의 인기 여행지")
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
}

// MARK: - Providing Function

extension PopularCollectionViewDataSource {
    func set(nearCities: [SearchHomeEntity.City]) {
        self.nearCities = nearCities
    }
}
