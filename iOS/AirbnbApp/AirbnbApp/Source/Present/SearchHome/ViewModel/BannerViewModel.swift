//
//  BannerViewModel.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/30.
//

import Foundation

final class BannerViewModel: ViewModelBindable {
    
    let loadAction = PublishRelay<Void>()
    let loadedState = PublishRelay<[CellViewModelable]>()
    
    @NetworkInject(keypath: \.searchHomeRepository)
    private var repository: SearchHomeRepository
    
    init() {
        loadAction.bind(onNext: { [weak self] in
            self?.repository.requestHeroBanner { result in
                switch result {
                case .success(let heroBanner):
                    let viewModels = heroBanner
                        .banners
                        .map { BannerCellViewModel(banner: $0) }
                    self?.loadedState.accept(viewModels)
                case .failure(let error):
                    print(error.localizedDescription) // TODO: Error 처리
                }
            }
        })
    }
    
}
