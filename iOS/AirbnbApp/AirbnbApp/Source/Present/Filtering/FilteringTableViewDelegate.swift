//
//  FilteringTableViewDelegate.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/07.
//

import UIKit

final class FilteringTableViewDelegate: NSObject, UITableViewDelegate {
    let selectedCell = PublishRelay<Int>()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell.accept(indexPath.item)
    }
}

// MARK: - Providing Function

extension FilteringTableViewDelegate {
    func bind(_ value: @escaping (Int) -> Void) {
        selectedCell.bind(onNext: value)
    }
}
