//
//  SearchResultViewCell.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/29.
//

import UIKit

class SearchResultViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return "\(self)"
    }
    
    private lazy var imageContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.Custom.gray3.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var cityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "mappin.and.ellipse")?
            .withAlignmentRectInsets(UIEdgeInsets(top: -21, left: -23, bottom: -21, right: -23))
        imageView.tintColor = .Custom.gray3
        return imageView
    }()
    
    private lazy var descriptionLabel = CustomLabel(font: .NotoSans.regular,
                                                    fontColor: .Custom.gray1)
    
    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 4
        [descriptionLabel].forEach { subview in
            stackView.addArrangedSubview(subview)
        }
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutImageContainerView()
        layoutInformationStackView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutImageContainerView()
        layoutInformationStackView()
    }
}

// MARK: - View Layout

private extension SearchResultViewCell {
    
    func layoutImageContainerView() {
        addSubview(imageContainerView)
        imageContainerView.addSubview(cityImageView)
        
        imageContainerView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(imageContainerView.snp.height)
        }
        
        cityImageView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func layoutInformationStackView() {
        addSubview(informationStackView)
        
        informationStackView.snp.makeConstraints { make in
            make.leading.equalTo(imageContainerView.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(imageContainerView.snp.centerY)
        }
    }
    
}

// MARK: - Providing Function

extension SearchResultViewCell {
    
    func setDescription(text: String) {
        descriptionLabel.text = text
    }
}
