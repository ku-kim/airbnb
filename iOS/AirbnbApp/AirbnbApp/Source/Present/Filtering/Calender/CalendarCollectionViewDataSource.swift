//
//  CalendarCollectionViewDataSource.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import UIKit

final class CalendarCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    let loadCalender = PublishRelay<YearViewModel>()
    
    let selectedCell = PublishRelay<IndexPath>()
    let selectedCellAction = PublishRelay<Void>()
    
    private var calendar: YearViewModel = YearViewModel()
    
    override init() {
        super.init()
        loadCalender.bind { [ weak self ] calendar in
            self?.calendar = calendar
        }
        
        selectedCell.bind { [ weak self ] indexPath in
            self?.calendar.selectDay(at: indexPath)
            self?.selectedCellAction.accept(())
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calendar.getMonthViewModel(at: section).count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return calendar.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: CalendarHeaderView.identifier,
                for: indexPath
              ) as? CalendarHeaderView else { return UICollectionReusableView() }
        let viewModel = calendar.getMonthViewModel(at: indexPath.section)
        
        headerView.configure(with: viewModel)
  
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarViewCell.identifier, for: indexPath) as? CalendarViewCell else {
            return UICollectionViewCell()
        }
        
        let item = calendar.getMonthViewModel(at: indexPath.section).getCellViewModel(at: indexPath.item)
        cell.configure(with: item)
        return cell
    }
    
}

// MARK: - Providing Function

extension CalendarCollectionViewDataSource {
    
    func bindSelectedCellAction(_ value: @escaping () -> Void) {
        selectedCellAction.bind(onNext: value)
    }
    
}
