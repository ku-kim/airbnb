//
//  FilteringTableVIewDataSource.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/04.
//

import UIKit

final class FilteringTableVIewDataSource: NSObject, UITableViewDataSource {
    
    var conditionMap = FilteringCondition.allCases.reduce(into: [FilteringCondition: String]()) {
        $0[$1] = ""
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
