//
//  CalendarCollectionViewDelegate.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import UIKit

final class CalendarCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    let selectedCell = PublishRelay<IndexPath>()
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell.accept(indexPath)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
        
}
