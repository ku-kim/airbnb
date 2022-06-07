//
//  CalendarViewController.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/07.
//

import UIKit

final class CalendarViewController: UIViewController {
    
    let loadedRange = PublishRelay<String>()
    
    private let viewModel = YearViewModel()
    
    private lazy var weekDayStackView = WeekDaysStackView()
    
    private lazy var calendarCollectionViewDataSource = CalendarCollectionViewDataSource()
    private lazy var calendarCollectionViewDelegate = CalendarCollectionViewDelegate()
    private lazy var calendarCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: SectionLayoutFactory.createCalendarLayout())
        collectionView.register(CalendarViewCell.self, forCellWithReuseIdentifier: CalendarViewCell.identifier)
        collectionView.register(CalendarHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CalendarHeaderView.identifier)
        collectionView.dataSource = self.calendarCollectionViewDataSource
        collectionView.delegate = self.calendarCollectionViewDelegate
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutWeekDatyStackView()
        layoutCalendarCollectionView()
        bind()
    }

}

private extension CalendarViewController {
    func bind() {
        
        viewModel.loadedCalendar.bind { [ weak self ] calender in
            self?.calendarCollectionViewDataSource.loadCalender.accept(calender)
        }
        
        viewModel.loadedRange.bind { [ weak self ] dates in
            self?.loadedRange.accept(dates)
        }
        
        calendarCollectionViewDataSource.bindSelectedCellAction { [ weak self ] in
            self?.calendarCollectionView.reloadData()
        }
        calendarCollectionViewDelegate.bindSelectedCell { [ weak self ] indexPath in
            self?.calendarCollectionViewDataSource.selectedCell.accept(indexPath)
        }

        viewModel.loadCalendar.accept(())

    }
    
    func layoutWeekDatyStackView() {
        view.addSubview(weekDayStackView)
        
        weekDayStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func layoutCalendarCollectionView() {
        view.addSubview(calendarCollectionView)
        calendarCollectionView.snp.makeConstraints { make in
            make.top.equalTo(weekDayStackView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(weekDayStackView.snp.width)
        }
    }
}
