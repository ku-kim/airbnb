//
//  TravelThemeViewCell.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/24.
//

import UIKit
import SnapKit

final class TravelThemeViewCell: UICollectionViewCell {
    
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
        fatalError("init with coder is unavailable")
    }
}

// MARK: - View Layout

private extension TravelThemeViewCell {
    
    func layoutImageView() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
    
    func layoutDescriptionLabel() {
        addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

// MARK: - Providing Function

extension TravelThemeViewCell {
    
    func setImageView(image: UIImage) {
        imageView.image = image
    }
    
    func setDescriptionLabel(text: String) {
        descriptionLabel.text = text
    }
}
