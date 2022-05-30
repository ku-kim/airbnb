//
//  HeroImageViewCell.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/24.
//

import UIKit
import SnapKit

final class HeroImageViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return "\(self)"
    }
    
    private lazy var heroImageView: UIImageView = {
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
        layoutHeroImageView()
        layoutContainerStackView()
        layoutReceiveIdeaButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init with coder is unavailable")
    }
}

// MARK: - View Layout

private extension HeroImageViewCell {
    
    func layoutHeroImageView() {
        addSubview(heroImageView)
        
        heroImageView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
            make.height.width.equalToSuperview()
        }
    }
    
    func layoutContainerStackView() {
        heroImageView.addSubview(containerStackView)
        
        containerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(105)
        }
    }
    
    func layoutReceiveIdeaButton() {
        heroImageView.addSubview(receiveIdeaButton)
        
        receiveIdeaButton.snp.makeConstraints { make in
            make.top.equalTo(containerStackView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(38)
        }
    }
    
}

// MARK: - Providing Function

extension HeroImageViewCell {
    
    func setHeroImageView(image: UIImage) {
        heroImageView.image = image
    }
    
    func setTitleLabel(text: String) {
        titleLabel.text = text
    }
    
    func setDescriptionLabel(text: String) {
        descriptionLabel.text = text
    }
}
