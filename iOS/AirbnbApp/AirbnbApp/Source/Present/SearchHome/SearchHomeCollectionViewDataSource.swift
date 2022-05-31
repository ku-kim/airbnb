//
//  SearchHomeCollectionViewDataSource.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/23.
//

import UIKit

final class SearchHomeCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    // TODO: Private으로 변경
    var nearCities: [SearchHomeEntity.City] = []
    var banners: [SearchHomeEntity.Banner] = []
    var themeJourney: [SearchHomeEntity.Theme] = []
    
    @NetworkInject(keypath: \.imageManager)
    private var imageManager: ImageManager
    
    @NetworkInject(keypath: \.searchHomeRepositoryImplement)
    private var repository: SearchHomeRepositoryImpl
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionKind = SearchHomeCollectionViewSection(rawValue: section) else { return 0 }
        
        switch sectionKind {
        case .heroBanner:
            return banners.count
        case .nearCity:
            return nearCities.count
        case .themeJourney:
            return themeJourney.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionKind = SearchHomeCollectionViewSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
        switch sectionKind {
        case .heroBanner:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroBannerViewCell.identifier, for: indexPath) as? HeroBannerViewCell else {
                return UICollectionViewCell()
            }
            
            let item = banners[indexPath.item]
            
            let imageUrl = URL(string: item.imageUrl)
            imageManager.fetchImage(from: imageUrl) { image in
                DispatchQueue.main.async {
                    cell.setHeroImageView(image: image ?? UIImage())
                }
            }
            cell.setTitleLabel(text: item.title)
            cell.setDescriptionLabel(text: item.description)
            return cell
            
        case .nearCity:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityViewCell.identifier, for: indexPath) as? CityViewCell else {
                return UICollectionViewCell()
            }
            
            let item = nearCities[indexPath.item]
            
            let imageUrl = URL(string: item.imageUrl)
            imageManager.fetchImage(from: imageUrl) { image in
                DispatchQueue.main.async {
                    cell.setCityImageView(image: image ?? UIImage())
                    // TODO: image가 nil일 경우 handling하는 에러 구현하기
                }
            }
            
            cell.setCityTitleLabel(text: item.cityName)
            cell.setDistanceLabel(text: item.time.convertIntoTime())
            return cell
            
        case .themeJourney:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThemeJourneyViewCell.identifier, for: indexPath) as? ThemeJourneyViewCell else {
                return UICollectionViewCell()
            }
            
            let item = themeJourney[indexPath.item]
            let imageUrl = URL(string: item.imageUrl)
            imageManager.fetchImage(from: imageUrl) { image in
                DispatchQueue.main.async {
                    cell.setImageView(image: image ?? UIImage())
                    // TODO: image가 nil일 경우 handling하는 에러 구현하기
                }
            }
            
            cell.setDescriptionLabel(text: item.description)
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SearchHomeCollectionViewSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SearchHomeHeaderView.identifier,
                for: indexPath
            ) as? SearchHomeHeaderView else { return UICollectionReusableView() }
            
            headerView.setHeaderLabel(text: SearchHomeCollectionViewSection.allCases[indexPath.section].header)
            return headerView
        }
        
        return UICollectionReusableView()
    }
}
