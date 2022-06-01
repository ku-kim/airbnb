//
//  SearchViewController.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/29.
//

import UIKit
import MapKit

final class SearchViewController: UIViewController {
    
    private let viewModel: NearCityViewModel
    
    private var searchedLocations = PublishRelay<[MKLocalSearchCompletion]>()
    
    private lazy var searchBarDelegate = SearchBarDelegate()
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.delegate = searchBarDelegate
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "어디로 여행가세요?"
        searchController.searchBar.showsCancelButton = false
        return searchController
    }()
    
    init(viewModel: NearCityViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var popularCollectionViewDataSource = PopularCollectionViewDataSource()
    private lazy var searchCollectionViewDataSource = SearchCollectionViewDataSource()
    
    private lazy var searchCollectionViewDelegate = SearchCollectionViewDelegate()
    
    private lazy var popularCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: SectionLayoutFactory.createPopularDestinationLayout(isHeaderExist: true))
        collectionView.register(CityViewCell.self, forCellWithReuseIdentifier: CityViewCell.identifier)
        collectionView.register(PopularHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: PopularHeaderView.identifier)
        collectionView.dataSource = self.popularCollectionViewDataSource
        return collectionView
    }()
    
    private lazy var searchResultCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: SectionLayoutFactory.createPopularDestinationLayout(isHeaderExist: false))
        collectionView.register(SearchResultViewCell.self, forCellWithReuseIdentifier: SearchResultViewCell.identifier)
        collectionView.dataSource = searchCollectionViewDataSource
        collectionView.delegate = searchCollectionViewDelegate
        collectionView.isHidden = true
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        layoutDestinationCollectionView()
        layoutSearchResultCollectionView()
        bind()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

// MARK: - View Layout

private extension SearchViewController {
    
    func bind() {
        searchedLocations.bind { [weak self] locations in
            self?.searchCollectionViewDataSource.set(locations: locations)
            self?.searchResultCollectionView.reloadData()
        }
        
        searchBarDelegate.bindEditTextField { [weak self] locations in
            self?.popularCollectionView.isHidden = true
            self?.searchResultCollectionView.isHidden = false
            self?.searchedLocations.accept(locations)
        }
        
        searchBarDelegate.bindDismissTextField { [weak self] in
            self?.searchResultCollectionView.isHidden = true
            self?.popularCollectionView.isHidden = false
        }
        
        viewModel.bind { [weak self] cities in
//            self?.popularCollectionViewDataSource.set(nearCities: cities)
//            self?.popularCollectionView.reloadData()
        }
        
        searchCollectionViewDelegate.selectedCell
            .bind { [weak self] index in
                self?.searchCollectionViewDataSource.selectedCellIndex.accept(index)
        }
        
        searchCollectionViewDataSource.selectedLocation
            .bind { [weak self] location in
                self?.navigationItem.backButtonTitle = "뒤로"
                self?.navigationController?.pushViewController(FilteringViewController(location: location), animated: true)
        }
        
        viewModel.accept(())
    }
    
    func configureSearchController() {
        self.navigationController?.navigationBar.backgroundColor = .Custom.gray6
        self.navigationItem.searchController = self.searchController
        self.navigationItem.title = "숙소 찾기"
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func layoutDestinationCollectionView() {
        view.addSubview(popularCollectionView)
        
        popularCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    func layoutSearchResultCollectionView() {
        view.addSubview(searchResultCollectionView)
        
        searchResultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
