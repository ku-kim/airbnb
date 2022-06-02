//
//  ThemeViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/30.
//

import Foundation

final class ThemeViewModel: ViewModelBindable {
    
    typealias actionType = Void
    typealias stateType = [CellViewModelable]
    
    private(set) var loadAction = PublishRelay<actionType>()
    private(set) var loadedState = PublishRelay<stateType>()
    
    @NetworkInject(keypath: \.searchHomeRepositoryImplement)
    private var repository: SearchHomeRepositoryImpl
    
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

// MARK: - Providing Function

extension ThemeViewModel {
    func accept(_ value: actionType) {
        loadAction.accept(value)
    }
    
    func bind(_ completion: @escaping (stateType) -> Void) {
        loadedState.bind(onNext: completion)
    }
}
