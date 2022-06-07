//
//  WeekDaysStackView.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import UIKit

final class WeekDaysStackView: UIStackView {
    
    private let weekDayLabel: (String) -> CustomLabel = { (day) -> CustomLabel in
        CustomLabel(text: day,
                    font: .SFProDisplay.regular(12),
                    fontColor: .Custom.gray3)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    @available (*, unavailable)
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
}

private extension WeekDaysStackView {
    func configure() {
        ["일", "월", "화", "수", "목", "금", "토"].forEach { day in
            let label = weekDayLabel(day)
            label.textAlignment = .center
            label.frame = bounds
            addArrangedSubview(label)
        }
        distribution = .fillEqually
    }
}
