//
//  FilteringViewController.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/31.
//

import SnapKit
import UIKit

class FilteringViewController: UIViewController {
    
    private var viewModel: FilteringViewModel?
    
    private let priceRangeView = PriceRangeViewController(viewModel: PriceRangeViewModel())
    
    private var childViewControllerMap: [FilteringCondition: UIViewController] = [.checkInAndOut: CalendarViewController(), .headCount: HeadCountViewController()]
    
    private var targetViewController: UIViewController = UIViewController() {
        didSet(previousViewController) {
            previousViewController.view.isHidden = true
        }
        willSet(presentViewController) {
            presentViewController.view.isHidden = false
        }
    }
    
    private lazy var tableHeaderView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0.0, height: 0.5)))
        view.backgroundColor = .systemGray3
        return view
    }()
    
    private lazy var tableViewDataSource = FilteringTableVIewDataSource()
    private lazy var tableViewDelegate = FilteringTableViewDelegate()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        tableView.register(FilteringTableViewCell.self, forCellReuseIdentifier: FilteringTableViewCell.identifier)
        tableView.rowHeight = 44 // TODO: Cell Height Constant로 변경
        tableView.tableHeaderView = tableHeaderView
        return tableView
    }()
    
    private let nextStepView = NextStepView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutNextStepView()
        layoutTableView()
    }
    
    init(viewModel: FilteringViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        configure()
        bind()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutNextStepView()
        layoutTableView()
    }
    
    private func configure() {
        title = "숙소 찾기"
        view.backgroundColor = .systemBackground
        
        childViewControllerMap.forEach {
            let childViewController = $0.value
            childViewController.view.isHidden = true
            addChild(childViewController)
        }
        
        guard let initialViewController = childViewControllerMap[.checkInAndOut] else { return }
        targetViewController = initialViewController
    }
    
    private func bind() {
        guard let vc = childViewControllerMap[.checkInAndOut] as? CalendarViewController else { return }
        vc.loadedRange.bind { [ weak self ] dates in
            
            self?.tableViewDataSource.conditionMap[.checkInAndOut] = dates
            self?.tableView.reloadData()
        }
        
        viewModel?.loadedLocationName.bind { [weak self] locationName in
            self?.tableViewDataSource.conditionMap[.location] = locationName
            self?.tableView.reloadData()
        }
        
        tableViewDelegate.bind { [ weak self ] index in
            self?.tableViewDataSource.accept(index)
        }
        
        tableViewDataSource.bind { [ weak self ] condition in
            guard let targetVC = self?.childViewControllerMap[condition] else { return }
            if self?.targetViewController == targetVC { return }
            self?.targetViewController = targetVC
        }
        
        viewModel?.loadLoacationName.accept(())
    }
    
}

// MARK: - View Layout

private extension FilteringViewController {
    
    func layoutNextStepView() {
        view.addSubview(nextStepView)
        
        nextStepView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(83)
        }
    }
    
    func layoutTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.height.equalTo(44 * 4)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(nextStepView.snp.top)
        }
    }
    
}
