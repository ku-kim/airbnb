//
//  HeroBannerViewCell.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/24.
//

import UIKit
import SnapKit

final class HeroBannerViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return "\(self)"
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel = CustomLabel(text: "",
                                              font: .SFProDisplay.medium,
                                              fontColor: .Custom.black)
    
    private lazy var descriptionLabel = CustomLabel(text: "",
                                                    font: .SFProDisplay.regular(17),
                                                    fontColor: .Custom.gray1)
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .equalSpacing
        [titleLabel, descriptionLabel].forEach { subview in
            stackView.addArrangedSubview(subview)
        }
        return stackView
    }()
    
    private lazy var receiveIdeaButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.Custom.gray1
        button.setTitle("여행 아이디어 얻기", for: .normal)
        button.setTitleColor(UIColor.Custom.white, for: .normal)
        button.layer.cornerRadius = 10
        var configuration = UIButton.Configuration.bordered()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        button.configuration = configuration
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutHeroImageView()
        layoutContainerStackView()
        layoutReceiveIdeaButton()
    }
}

// MARK: - View Layout

private extension HeroBannerViewCell {
    
    func layoutHeroImageView() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
            make.height.width.equalToSuperview()
        }
    }
    
    func layoutContainerStackView() {
        imageView.addSubview(containerStackView)
        
        containerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-105)
        }
    }
    
    func layoutReceiveIdeaButton() {
        imageView.addSubview(receiveIdeaButton)
        
        receiveIdeaButton.snp.makeConstraints { make in
            make.top.equalTo(containerStackView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(38)
        }
    }
    
}

// MARK: - Providing Function

extension HeroBannerViewCell {
    
    func setHeroImageView(image: UIImage) {
        imageView.image = image
    }
    
    func setTitleLabel(text: String) {
        titleLabel.text = text
    }
    
    func setDescriptionLabel(text: String) {
        descriptionLabel.text = text
    }
}
