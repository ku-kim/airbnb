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
        paintCell(with: false)
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
    func paintCell(with selection: Bool) {
        selection ? select() : deSelect()
    }
    
    func select() {
        dayLabel.backgroundColor = .Custom.gray1
        dayLabel.clipsToBounds = true
        dayLabel.layer.cornerRadius = self.frame.height/2
        dayLabel.textColor = .Custom.white
    }
    
    func deSelect() {
        dayLabel.backgroundColor = .Custom.white
        dayLabel.clipsToBounds = false
        dayLabel.layer.cornerRadius = 0
        dayLabel.textColor = .Custom.gray1
    }
    
    func configure(with viewModel: CalendarCellViewModel) {
        let day = viewModel.getDay()
        if day == "0" {
            dayLabel.text = ""
            return
        }
        let selected = viewModel.getSelection()
        paintCell(with: selected)
        dayLabel.text = day
    }
    
    func invalidDay() {
        dayLabel.textColor = .Custom.gray4
    }
    
    func setColor(color: UIColor) {
        dayLabel.backgroundColor = color
    }
    
}
