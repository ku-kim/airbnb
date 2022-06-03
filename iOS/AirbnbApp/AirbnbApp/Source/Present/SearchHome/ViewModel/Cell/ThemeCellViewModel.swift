//
//  ThemeCellViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import Foundation

class ThemeCellViewModel: CellViewModelable {
    
    let loadThemeData = PublishRelay<Void>()
    let loadedThemeName = PublishRelay<String>()
    let loadedThemeImage = PublishRelay<String>()
    
    init(theme: SearchHomeEntity.Theme) {
        self.loadThemeData.bind { [ weak self ] in
            self?.loadedThemeName.accept(theme.title)
            self?.loadedThemeImage.accept(theme.imageUrl)
        }
    }
    
    func disposeBind() {
        loadThemeData.clearBinds()
        loadedThemeName.clearBinds()
        loadedThemeImage.clearBinds()
    }
    
}
