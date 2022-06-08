//
//  FilteringTableViewCell.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/04.
//

import SnapKit
import UIKit

class FilteringTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return "\(self)"
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutTitleLabel()
        layoutConditionLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutTitleLabel()
        layoutConditionLabel()
    }
}

// MARK: - View Layout

private extension FilteringTableViewCell {
    
    func layoutTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(11)
            make.leading.equalToSuperview().inset(16)
        }
    }
    
    func layoutConditionLabel() {
        addSubview(conditionLabel)
        
        conditionLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(11)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
}

// MARK: - Providing Function

extension FilteringTableViewCell {
    
    func setTitleLabel(text: String?) {
        titleLabel.text = text
    }
    
    func setConditionLabel(text: String?) {
        conditionLabel.text = text
    }
    
}
