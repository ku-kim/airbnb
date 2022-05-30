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
    
    private lazy var cityImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.image = UIImage(named: "Mockimage.png")
        return image
    }()
    
    private lazy var descriptionLabel = CustomLabel(text: "양재동, 서초구, 서울특별시",
                                                    font: .NotoSans.regular,
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
        layoutCityImageView()
        layoutInformationStackView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init with coder is unavailable")
    }
}

// MARK: - View Layout

private extension SearchResultViewCell {
    
    func layoutCityImageView() {
        addSubview(cityImageView)
        
        cityImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.height.width.equalTo(74)
        }
    }
    
    func layoutInformationStackView() {
        addSubview(informationStackView)
        
        informationStackView.snp.makeConstraints { make in
            make.leading.equalTo(cityImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(cityImageView.snp.centerY)
        }
    }
    
}

// MARK: - Providing Function

extension SearchResultViewCell {
    
    func setDescription(text: String) {
        descriptionLabel.text = text
    }
}
