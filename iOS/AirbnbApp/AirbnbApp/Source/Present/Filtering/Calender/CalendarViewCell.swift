//
//  CalendarViewCell.swift
//  AirbnbApp
//
//  Created by dale on 2022/06/02.
//

import UIKit
import SnapKit

final class CalendarViewCell: UICollectionViewCell {
    static var identifier: String {
        return "\(self)"
    }
    
    private lazy var dayLabel: CustomLabel = {
    let label = CustomLabel(font: .SFProDisplay.bold(12), fontColor: .Custom.gray1)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutDayLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutDayLabel()
    }
    
    override func prepareForReuse() {
        paintCell(isSelected: false, isBetween: false, isFirst: false)
    }
}

private extension CalendarViewCell {
    func paintCell(isSelected: Bool, isBetween: Bool, isFirst: Bool) {
        if isSelected {
            select(isFirst: isFirst)
            return
        }
        
        if isBetween {
            betWeen()
            return
        }
        
        deSelect()
    }
    
    func select(isFirst: Bool) {
        dayLabel.backgroundColor = .Custom.gray1
        dayLabel.clipsToBounds = true
        dayLabel.layer.cornerRadius = self.frame.height/2
        dayLabel.textColor = .Custom.white
        self.backgroundView = UIView()
        isFirst ? self.backgroundView?.setGradient(color1: .Custom.white, color2: .Custom.gray6) : self.backgroundView?.setGradient(color1: .Custom.gray6, color2: .Custom.white)
    }
    
    func deSelect() {
        dayLabel.backgroundColor = .Custom.white
        dayLabel.clipsToBounds = false
        dayLabel.layer.cornerRadius = 0
        dayLabel.textColor = .Custom.gray1
        self.backgroundView = nil
    }
    
    func invalid() {
        dayLabel.backgroundColor = .Custom.white
        dayLabel.clipsToBounds = false
        dayLabel.layer.cornerRadius = 0
        dayLabel.textColor = .Custom.gray4
        self.backgroundView = nil
    }
    
    func betWeen() {
        dayLabel.backgroundColor = .Custom.gray6
    }
    
}

// MARK: - View Layout

private extension CalendarViewCell {
    
    func layoutDayLabel() {
        contentView.addSubview(dayLabel)
        
        dayLabel.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
}

// MARK: - Providing Function

extension CalendarViewCell {
    
    func configure(with viewModel: DayViewModel) {
        let day = viewModel.getDay()
        let isSelected = viewModel.getSelection()
        let isBetween = viewModel.getIsBetween()
        let isFirst = viewModel.getIsFirst()
        
        paintCell(isSelected: isSelected, isBetween: isBetween, isFirst: isFirst)
        dayLabel.text = day
    }
    
}
