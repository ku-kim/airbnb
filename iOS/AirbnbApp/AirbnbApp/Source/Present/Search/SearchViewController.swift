//
//  SearchViewController.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/29.
//

import UIKit
import MapKit

final class SearchViewController: UIViewController, MKLocalSearchCompleterDelegate {
    
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
    
    private lazy var popularCollectionViewDataSource = PopularCollectionViewDataSource()
    private lazy var searchCollectionViewDataSource = SearchCollectionViewDataSource()
    
    private lazy var popularCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: SectionLayoutFactory.createPopularDestinationLayout())
        collectionView.register(CityViewCell.self, forCellWithReuseIdentifier: CityViewCell.identifier)
        collectionView.register(PopularHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: PopularHeaderView.identifier)
        collectionView.dataSource = self.popularCollectionViewDataSource
        return collectionView
    }()
    
    private lazy var searchResultCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: SectionLayoutFactory.createPopularDestinationLayout())
        collectionView.register(SearchResultViewCell.self, forCellWithReuseIdentifier: SearchResultViewCell.identifier)
        collectionView.dataSource = self.searchCollectionViewDataSource
        collectionView.isHidden = true
        return collectionView
    }()
    
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
            self?.searchCollectionViewDataSource.locations = locations
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
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
