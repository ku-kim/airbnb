//
//  ThemeJourneyViewCell.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/24.
//

import UIKit
import SnapKit

final class ThemeJourneyViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return "\(self)"
    }
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var descriptionLabel = CustomLabel(font: .NotoSans.medium,
                                                    fontColor: .Custom.gray1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutImageView()
        layoutDescriptionLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutImageView()
        layoutDescriptionLabel()
    }
}

// MARK: - View Layout

private extension ThemeJourneyViewCell {
    
    func layoutImageView() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.82)
        }
    }
    
    func layoutDescriptionLabel() {
        addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
    }
    
}

// MARK: - Providing Function

extension ThemeJourneyViewCell {
    
    func setImageView(image: UIImage) {
        imageView.image = image
    }
    
    func setDescriptionLabel(text: String) {
        descriptionLabel.text = text
    }
}
