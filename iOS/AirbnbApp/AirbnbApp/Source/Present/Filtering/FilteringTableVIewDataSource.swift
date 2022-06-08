//
//  FilteringTableVIewDataSource.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/04.
//

import UIKit

final class FilteringTableVIewDataSource: NSObject, UITableViewDataSource {
    
    let selectedCellIndex = PublishRelay<Int>()
    let selectedCondition = PublishRelay<FilteringCondition>()
    
    var conditionMap = FilteringCondition.allCases.reduce(into: [FilteringCondition: String]()) {
        $0[$1] = ""
    }
    
    override init() {
        super.init()
        
        selectedCellIndex.bind { [ weak self ] index in
            let condition = FilteringCondition.allCases[index]
            self?.selectedCondition.accept(condition)
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conditionMap.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilteringTableViewCell.identifier, for: indexPath)
                as? FilteringTableViewCell else {
            return UITableViewCell()
        }
        let condition = FilteringCondition.allCases[indexPath.item]
        
        let item = conditionMap[condition]
        cell.setTitleLabel(text: condition.title)
        cell.setConditionLabel(text: item)
        return cell
    }
    
}

extension FilteringTableVIewDataSource {
    
    func accept(_ value: Int) {
        selectedCellIndex.accept(value)
    }
    
    func bind(_ value: @escaping (FilteringCondition) -> Void) {
        selectedCondition.bind(onNext: value)
    }
}
