//
//  CustomSearchBar.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/24.
//

import UIKit
import SnapKit

final class CustomSearchBar: UISearchBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutSearchTextField()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        layoutSearchTextField()
    }
    
    private func configure() {
        backgroundImage = UIImage()
        searchTextField.backgroundColor = .Custom.gray5
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "어디로 여행가세요?",
            attributes: [.foregroundColor: UIColor.Custom.gray3]
        )
    }
    
    private func layoutSearchTextField() {
        searchTextField.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
    
}
