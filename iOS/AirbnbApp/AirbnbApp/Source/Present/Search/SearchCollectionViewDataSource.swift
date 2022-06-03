//
//  SearchCollectionViewDataSource.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/29.
//

import UIKit
import MapKit

final class SearchCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var locations: [MKLocalSearchCompletion] = []
    
    let selectedCellIndex = PublishRelay<Int>()
    let selectedLocation = PublishRelay<MKLocalSearchCompletion>()
    
    override init() {
        super.init()
        selectedCellIndex.bind { [weak self] index in
            guard let index = self?.locations[index] else { return }
            self?.selectedLocation.accept(index)
        }
    }
    
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

// MARK: - Providing Function

extension SearchCollectionViewDataSource {
    
    func configure(with locations: [MKLocalSearchCompletion]) {
        self.locations = locations
    }
    
}
