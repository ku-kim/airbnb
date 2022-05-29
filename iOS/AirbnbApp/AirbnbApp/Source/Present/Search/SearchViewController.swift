//
//  SearchViewController.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/29.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private lazy var searchBarDelegate = DestinationSearchBarDelegate()
    private lazy var searchBar: DestinationSearchBar = {
        let searchBar = DestinationSearchBar()
        searchBar.delegate = searchBarDelegate
        return searchBar
    }()
    
    private lazy var popularCollectionViewDataSource = PopularCollectionViewDataSource()
    private lazy var popularCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: SectionLayoutFactory.createPopularDestinationLayout())
        collectionView.register(NearDestinationViewCell.self, forCellWithReuseIdentifier: NearDestinationViewCell.identifier)
        collectionView.register(PopularHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: PopularHeaderView.identifier)
        collectionView.dataSource = self.popularCollectionViewDataSource
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSearchBar()
        layoutDestinationCollectionView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

// MARK: - View Layout

private extension SearchViewController {
    
    func layoutSearchBar() {
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func layoutDestinationCollectionView() {
        view.addSubview(popularCollectionView)
        
        popularCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
