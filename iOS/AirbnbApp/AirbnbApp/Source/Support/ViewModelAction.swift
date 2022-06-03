//
//  ViewModelAction.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/26.
//

import Foundation

protocol ViewModelAction {
    var loadAction: PublishRelay<Void> { get }
}
