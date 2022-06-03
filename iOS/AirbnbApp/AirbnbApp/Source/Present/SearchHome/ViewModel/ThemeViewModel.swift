//
//  ThemeViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/30.
//

import Foundation

final class ThemeViewModel: ViewModelBindable {
    
    let loadAction = PublishRelay<Void>()
    let loadedState = PublishRelay<[CellViewModelable]>()
    
    @NetworkInject(keypath: \.searchHomeRepository)
    private var repository: SearchHomeRepository
    
    init() {
        loadAction.bind(onNext: { [weak self] in
            self?.repository.requestTheme { result in
                switch result {
                case .success(let themeJourney) :
                    let viewModels = themeJourney
                        .themes
                        .map { ThemeCellViewModel(theme: $0) }
                    self?.loadedState.accept(viewModels)
                case .failure(let error):
                    print(error) // TODO: error
                }
            }
        })
    }
    
}
