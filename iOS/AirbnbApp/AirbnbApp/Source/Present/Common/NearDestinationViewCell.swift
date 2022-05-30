//
//  NearDestinationViewCell.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/23.
//

import UIKit
import SnapKit

final class NearDestinationViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return "\(self)"
    }
    
    private lazy var cityImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var cityTitleLabel = CustomLabel(font: .SFProDisplay.semiBold,
                                                  fontColor: .Custom.gray1)
    
    private lazy var distanceLabel = CustomLabel(text: "차로 30분 거리",
                                                          font: .SFProDisplay.regular(17),
                                                          fontColor: .Custom.gray3)
    
    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 4
        [cityTitleLabel, distanceLabel].forEach { subview in
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

private extension NearDestinationViewCell {
    
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

extension NearDestinationViewCell {
    
    func setCityImageView(image: UIImage) {
        cityImageView.image = image
    }
    
    func setCityTitleLabel(text: String) {
        cityTitleLabel.text = text
    }
    
    func setDistanceLabel(text: Int) {
        distanceLabel.text = "\(text)"
    }
}
