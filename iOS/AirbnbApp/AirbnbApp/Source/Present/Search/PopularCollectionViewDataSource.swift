//
//  PopularCollectionViewDataSource.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/29.
//

import Foundation
import UIKit

final class PopularCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var mockCity: [String] = ["서울", "광주", "부산", "대구"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockCity.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityViewCell.identifier, for: indexPath) as? CityViewCell else {
            return UICollectionViewCell()
        }
        guard let image = UIImage(named: "mockimage.png") else { return cell }
        
        cell.setCityImageView(image: image)
        cell.setCityTitleLabel(text: mockCity[indexPath.item])
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
