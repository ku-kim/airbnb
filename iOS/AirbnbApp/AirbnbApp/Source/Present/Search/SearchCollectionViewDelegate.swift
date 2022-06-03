//
//  SearchCollectionViewDelegate.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/31.
//

import UIKit
import MapKit

final class SearchCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    let selectedCell = PublishRelay<Int>()
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        selectedCell.accept(indexPath.item)
    }
    
}
