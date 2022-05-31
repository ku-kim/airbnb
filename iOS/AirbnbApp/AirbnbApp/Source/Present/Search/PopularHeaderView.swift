//
//  PopularHeaderView.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/29.
//

import UIKit

final class PopularHeaderView: UICollectionReusableView {
    
    static var identifier: String {
        return "\(self)"
    }
    
    private let headerLabel = CustomLabel(font: .SFProDisplay.semiBold,
                                          fontColor: .Custom.black)
    
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

private extension PopularHeaderView {
    
    func layoutHeaderLabel() {
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - Providing Function

extension PopularHeaderView {
    
    func setHeaderLabel(text: String) {
        headerLabel.text = text
    }
}
