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
    
    private lazy var searchBarDelegate = DestinationSearchBarDelegate()
    private lazy var searchBar: DestinationSearchBar = {
        let searchBar = DestinationSearchBar()
        searchBar.delegate = searchBarDelegate
        return searchBar
    }()
    
    private lazy var destinationCollectionViewDataSource = DestinationCollecionViewDataSource()
    private lazy var destinationCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: SectionLayoutFactory.createCompositionalLayout())
        collectionView.register(HeroImageViewCell.self, forCellWithReuseIdentifier: HeroImageViewCell.identifier)
        collectionView.register(NearDestinationViewCell.self, forCellWithReuseIdentifier: NearDestinationViewCell.identifier)
        collectionView.register(TravelThemeViewCell.self, forCellWithReuseIdentifier: TravelThemeViewCell.identifier)
        collectionView.register(DestinationHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: DestinationHeaderView.identifier)
        collectionView.dataSource = self.destinationCollectionViewDataSource
        return collectionView
    }()
    
    init(viewModel: SearchHomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
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
        layoutSearchBar()
        layoutDestinationCollecionView()
        let endPoint = EndPoint.requestNearDestination(latitude: 35.1, longtitude: 123.1)
        Provider.foo(endPoint: endPoint)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func bind() {
        searchBarDelegate.tapTextField
            .bind { [weak self] in
                self?.navigationController?.pushViewController(UIViewController(), animated: true)
            }
        
        viewModel.bindHeader { [weak self] headers in
            self?.destinationCollectionViewDataSource.mockHeader = headers
            self?.destinationCollectionView.reloadData()
        }
        
        viewModel.bindImage { [weak self] imageName in
            self?.destinationCollectionViewDataSource.mockImage.append( UIImage(named: imageName) ?? UIImage())
            self?.destinationCollectionView.reloadData()
        }
        
        viewModel.bindTheme { [weak self] themes in
            self?.destinationCollectionViewDataSource.mockTheme = themes
            self?.destinationCollectionView.reloadData()
        }
        
        viewModel.bindCityName { [weak self] cityNames in
            self?.destinationCollectionViewDataSource.mockCity = cityNames
            self?.destinationCollectionView.reloadData()
        }
        
        viewModel.acceptHeader(value: ())
        viewModel.acceptImage(value: ())
        viewModel.acceptCityName(value: ())
        viewModel.acceptTheme(value: ())
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
    
    func layoutDestinationCollecionView() {
        view.addSubview(destinationCollectionView)
        
        destinationCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
