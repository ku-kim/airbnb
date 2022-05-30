//
//  DestinationCollecionViewDataSource.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/23.
//

import UIKit

final class DestinationCollecionViewDataSource: NSObject, UICollectionViewDataSource {
    
    // TODO: Private으로 변경
    var mockHeader: [String] = []
    var nearCities: [SearchHomeEntity.City] = []
    var banner: [SearchHomeEntity.Banner] = []
    var mockTheme: [String] = []
    
    let imageManager = ImageManager() // TODO: 주입?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sectionKind = DestinationCollectionViewSection(rawValue: section) else { return 0 }
        
        switch sectionKind {
        case .image:
            return banner.count
        case .nearby:
            return nearCities.count
        case .theme:
            return mockTheme.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let sectionKind = DestinationCollectionViewSection(rawValue: indexPath.section) else { return UICollectionViewCell() }
        
        switch sectionKind {
        case .image:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroImageViewCell.identifier, for: indexPath) as? HeroImageViewCell else {
                return UICollectionViewCell()
            }
            
            let item = banner[indexPath.item]
            
            let imageUrl = URL(string: item.imageUrl)
            imageManager.fetchImage(from: imageUrl) { image in
                DispatchQueue.main.async {
                    cell.setHeroImageView(image: image ?? UIImage())
                }
            }
            cell.setTitleLabel(text: item.title)
            cell.setDescriptionLabel(text: item.description)
            return cell
            
        case .nearby:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NearDestinationViewCell.identifier, for: indexPath) as? NearDestinationViewCell else {
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
            
            // TODO: 시간, 분 나누는 로직 추가해서 String으로 넘겨주기 "0시간 00분"
            cell.setDistanceLabel(text: item.time)
            return cell
            
        case .theme:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelThemeViewCell.identifier, for: indexPath) as? TravelThemeViewCell else {
                return UICollectionViewCell()
            }
            
            // TODO: Network에서 받아오는 이미지 사용하도록 변경
            guard let image = UIImage(named: "mockimage.png") else { return cell }
            cell.setImageView(image: image)
            cell.setDescriptionLabel(text: mockTheme[indexPath.item])
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mockHeader.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: DestinationHeaderView.identifier,
                for: indexPath
            ) as? DestinationHeaderView else { return UICollectionReusableView() }
            
            headerView.setHeaderLabel(text: mockHeader[indexPath.section])
            return headerView
        }
        
        return UICollectionReusableView()
    }
}
