//
//  SearchHomeHeaderView.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/24.
//

import UIKit
import SnapKit

final class SearchHomeHeaderView: UICollectionReusableView {
    
    static var identifier: String {
        return "\(self)"
    }
    
    private let headerLabel = CustomLabel(font: .SFProDisplay.regular(22),
                                          fontColor: .Custom.black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutHeaderLabel()
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutHeaderLabel()
    }
    
}

// MARK: - View Layout

private extension SearchHomeHeaderView {
    
    func layoutHeaderLabel() {
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

// MARK: - Providing Function

extension SearchHomeHeaderView {
    
    func setHeaderLabel(text: String) {
        headerLabel.text = text
    }
    
}
