//
//  CalendarViewController.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/07.
//

import UIKit

final class CalendarViewController: FilteringBaseViewController {
    
    private var viewModel: YearViewModel?
    
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
    
    init(viewModel: YearViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutWeekDatyStackView()
        layoutCalendarCollectionView()
        bind()
    }
    
}

private extension CalendarViewController {
    func bind() {
        
        viewModel?.loadedCalendar.bind { [weak self] calender in
            self?.calendarCollectionViewDataSource.loadCalender.accept(calender)
        }
        
//        viewModel?.updatedRange.bind { [weak self] dates in
//
//
//        }
        
        calendarCollectionViewDataSource.bindSelectedCellAction { [ weak self ] in
            self?.calendarCollectionView.reloadData()
        }
        calendarCollectionViewDelegate.bindSelectedCell { [ weak self ] indexPath in
            self?.calendarCollectionViewDataSource.selectedCell.accept(indexPath)
        }
        
        viewModel?.loadCalendar.accept(())
        
    }
    
    func layoutWeekDatyStackView() {
        view.addSubview(weekDayStackView)
        
        weekDayStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
    
    func layoutCalendarCollectionView() {
        view.addSubview(calendarCollectionView)
        
        calendarCollectionView.snp.makeConstraints { make in
            make.top.equalTo(weekDayStackView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
