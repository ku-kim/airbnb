//
//  CalendarHeaderView.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import UIKit

final class CalendarHeaderView: UICollectionReusableView {
    
    static var identifier: String {
        return "\(self)"
    }
    
    private let headerLabel: CustomLabel = {
        let customLabel = CustomLabel(font: .SFProDisplay.bold(16),
                                      fontColor: .Custom.black)
        return customLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutHeaderLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutHeaderLabel()
    }
}

// MARK: - View Layout

private extension CalendarHeaderView {
    
    func layoutHeaderLabel() {
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Providing Function

extension CalendarHeaderView {
    
    func configure(with viewModel: MonthViewModel) {
        let month = viewModel.getMonth()
        let year = viewModel.getYear()
        headerLabel.text = "\(year)년 \(month)월"
    }
    
}
