//
//  SearchHomeViewController.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/23.
//

import UIKit
import SnapKit

final class SearchHomeViewController: UIViewController {
    
    private let viewModel: SearchHomeViewModel
    
    private lazy var searchBarDelegate = SearchHomeSearchBarDelegate()
    private lazy var searchBar: CustomSearchBar = {
        let searchBar = CustomSearchBar()
        searchBar.delegate = searchBarDelegate
        return searchBar
    }()
    
    private lazy var collectionViewDataSource = SearchHomeCollectionViewDataSource()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: SectionLayoutFactory.createCompositionalLayout())
        collectionView.register(BannerViewCell.self, forCellWithReuseIdentifier: BannerViewCell.identifier)
        collectionView.register(CityViewCell.self, forCellWithReuseIdentifier: CityViewCell.identifier)
        collectionView.register(ThemeViewCell.self, forCellWithReuseIdentifier: ThemeViewCell.identifier)
        collectionView.register(SearchHomeHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SearchHomeHeaderView.identifier)
        collectionView.dataSource = self.collectionViewDataSource
        return collectionView
    }()
    
    init(viewModel: SearchHomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        layoutSearchBar()
        layoutNearCityCollectionView()
        configureNavigationItem()
    }
    
    private func bind() {
        searchBarDelegate.tapTextField
            .bind { [weak self] in
                self?.navigationController?.pushViewController(SearchViewController(viewModel: CityViewModel()), animated: true)
            }
        
        SearchHomeCollectionViewSection.allCases.forEach { section in
            viewModel.bind(sectionType: section) { [weak self] cellViewModels in
                self?.collectionViewDataSource
                    .configure(sectionType: section, with: cellViewModels)
                self?.collectionView.reloadSections(section.indexSet)
            }
        }
        
        SearchHomeCollectionViewSection.allCases.forEach { section in
            viewModel.accept(sectionType: section, value: ())
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func configureNavigationItem() {
        self.navigationItem.backButtonTitle = "뒤로"
    }
    
}

// MARK: - View Layout

private extension SearchHomeViewController {
    
    func layoutSearchBar() {
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func layoutNearCityCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
