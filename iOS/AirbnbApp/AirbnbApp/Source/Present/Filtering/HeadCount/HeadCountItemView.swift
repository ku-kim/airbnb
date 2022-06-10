//
//  HeadCountItemView.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/09.
//

import UIKit

final class HeadCountItemView: UIView {
    
    private let viewModel: HeadCountItemViewModel
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let plusButton = UIButton.CustomImage(systemName: .SFImage.plusButton)
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Custom.gray1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let minusButton = UIButton.CustomImage(systemName: .SFImage.minusButton)
    
    init(viewModel: HeadCountItemViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        bind()
        layoutTitleLabel()
        layoutDescriptionLabel()
        layoutPlusButton()
        layoutCountLabel()
        layoutMinusButton()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        viewModel.loadedTitle.bind { [weak self] text in
            self?.titleLabel.text = text
        }
        
        viewModel.loadedDescription.bind { [weak self] text in
            self?.descriptionLabel.text = text
        }
        
        viewModel.updateCount.bind { [weak self] count in
            self?.minusButton.isEnabled = count != 0
            self?.countLabel.text = "\(count)"
        }
        
        plusButton.addAction(UIAction(handler: { [weak self] _ in
            self?.viewModel.tappedAddButton.accept(1)
        }), for: .touchUpInside)
        
        minusButton.addAction(UIAction(handler: { [weak self] _ in
            self?.viewModel.tappedAddButton.accept(-1)
        }), for: .touchUpInside)
        
        viewModel.enablePlusButton.bind { [weak self] bool in
            self?.plusButton.isEnabled = bool
        }
        
        viewModel.loadContent.accept(())
    }
    
}

private extension UIButton {
    static func CustomImage(systemName: String) -> UIButton {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25,
                                                      weight: .light,
                                                      scale: .large)
        let image = UIImage(systemName: systemName, withConfiguration: largeConfig)
        let enableImage = image?.withTintColor(.Custom.gray1, renderingMode: .alwaysOriginal)
        let disableImage = image?.withTintColor(.Custom.gray5, renderingMode: .alwaysOriginal)
        
        let button = UIButton()
        button.setImage(enableImage, for: .normal)
        button.setImage(disableImage, for: .disabled)
        
        return button
    }
}

// MARK: - View Layout

private extension HeadCountItemView {
    
    func layoutTitleLabel() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview()
        }
    }
    
    func layoutDescriptionLabel() {
        addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
        }
    }
    
    func layoutPlusButton() {
        addSubview(plusButton)
        
        plusButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(36)
        }
    }
    
    func layoutCountLabel() {
        addSubview(countLabel)
        
        countLabel.snp.makeConstraints { make in
            make.trailing.equalTo(plusButton.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(36)
        }
    }
    
    func layoutMinusButton() {
        addSubview(minusButton)
        
        minusButton.snp.makeConstraints { make in
            make.trailing.equalTo(countLabel.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(36)
        }
    }
    
    func layout() {
        snp.makeConstraints { make in
            make.bottom.equalTo(descriptionLabel).offset(16)
        }
    }
    
}
