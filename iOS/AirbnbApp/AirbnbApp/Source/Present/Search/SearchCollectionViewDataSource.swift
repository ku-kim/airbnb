//
//  SearchCollectionViewDataSource.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/29.
//

import UIKit
import MapKit

final class SearchCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var locations: [MKLocalSearchCompletion] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultViewCell.identifier, for: indexPath) as? SearchResultViewCell else {
            return UICollectionViewCell()
        }
        cell.setDescription(text: locations[indexPath.item].title)
        
        return cell
    }
    
}
