//
//  ViewCellBindable.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import UIKit

protocol ViewCellBindable: UICollectionViewCell {
    func configure(with viewModel: CellViewModelable)
}
