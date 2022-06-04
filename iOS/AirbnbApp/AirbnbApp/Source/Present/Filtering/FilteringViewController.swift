//
//  FilteringViewController.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/31.
//

import UIKit
import MapKit

class FilteringViewController: UIViewController {
    
    private let location: MKLocalSearchCompletion
    
    private let viewModel = CalendarViewModel()
    
    private lazy var weekDayStackView = WeekDaysStackView()
    
    private lazy var calendarCollectionViewDataSource = CalendarCollectionViewDataSource()
    
    private lazy var calendarCollectionViewDelegate = CalendarCollectionViewDelegate()
    
    private lazy var calendarCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: SectionLayoutFactory.createCalendarLayout())
        collectionView.register(CalendarViewCell.self, forCellWithReuseIdentifier: CalendarViewCell.identifier)
        collectionView.register(CalendarHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CalendarHeaderView.identifier)
        collectionView.dataSource = self.calendarCollectionViewDataSource
        collectionView.delegate = self.calendarCollectionViewDelegate
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutWeekDatyStackView()
        layoutCalendarCollectionView()
        bind()

    }
    
    init(location: MKLocalSearchCompletion) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension FilteringViewController {
    func bind() {
        
        viewModel.loadedCalendar.bind { [ weak self ] calender in
            self?.calendarCollectionViewDataSource.loadCalender.accept(calender)
        }
         
        calendarCollectionViewDataSource.selectedCellAction.bind { [ weak self ] in
            self?.calendarCollectionView.reloadData()
        }
        calendarCollectionViewDelegate.selectedCell.bind { [ weak self ] indexPath in
            self?.calendarCollectionViewDataSource.selectedCell.accept(indexPath)
        }

        viewModel.loadCalendar.accept(())

    }
    
    func layoutWeekDatyStackView() {
        view.addSubview(weekDayStackView)
        
        weekDayStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
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
