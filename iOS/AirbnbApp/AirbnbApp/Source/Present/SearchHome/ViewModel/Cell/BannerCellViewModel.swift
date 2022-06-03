//
//  BannerCellViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import Foundation

class BannerCellViewModel: CellViewModelable {
    
    let loadBannerData = PublishRelay<Void>()
    let loadedBannerImage = PublishRelay<String>()
    let loadedBannerTitle = PublishRelay<String>()
    let loadedDescription = PublishRelay<String>()
    
    init(banner: SearchHomeEntity.Banner) {
        self.loadBannerData.bind { [ weak self ] in
            self?.loadedBannerTitle.accept(banner.title)
            self?.loadedBannerImage.accept(banner.imageUrl)
            self?.loadedDescription.accept(banner.description)
        }
    }
    
    func disposeBind() {
        loadedBannerImage.clearBinds()
        loadedBannerTitle.clearBinds()
        loadedDescription.clearBinds()
    }
    
}
