//
//  AgeCountStackView.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/05.
//

import SnapKit
import UIKit

final class AgeCountStackView: UIStackView {
    
    private var viewModel: CountViewModel?
    
    private let minusButton = UIButton.headCount(kind: .minus)
    private let plusButton = UIButton.headCount(kind: .plus)
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Custom.gray1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        axis = .horizontal
        spacing = 11
        distribution = .equalSpacing
        
        [minusButton, countLabel, plusButton].forEach {
            addArrangedSubview($0)
        }
    }
    
    func configure(viewModel: CountViewModel) {
        self.viewModel = viewModel
        
        viewModel.loadedCount.bind { [weak self] count in
            self?.countLabel.text = "\(count)"
        }
        
        viewModel.disablePlus.bind { [weak self] in
            self?.plusButton.disable()
        }
        
        viewModel.enablePlus.bind { [weak self] in
            self?.plusButton.enable()
        }
        
        viewModel.disableMinus.bind { [weak self] in
            self?.minusButton.disable()
        }
        
        viewModel.enableMinus.bind { [weak self] in
            self?.minusButton.enable()
        }
        
        plusButton.addAction(UIAction(handler: { [weak self] _ in
            self?.viewModel?.inputCountValue.accept(1)
        }), for: .touchUpInside)

        minusButton.addAction(UIAction(handler: { [weak self] _ in
            self?.viewModel?.inputCountValue.accept(-1)
        }), for: .touchUpInside)
    }
    
}

// MARK: - Private Extension

private extension UIButton {
    
    static func headCount(kind: HeadCountButton) -> UIButton {
        let button = UIButton()
        button.setTitle(kind.title, for: .normal)
        button.setTitleColor(kind.color, for: .normal)
        button.layer.cornerRadius = 30 / 2
        button.layer.borderColor = kind.color.cgColor
        button.layer.borderWidth = 2
        
        button.snp.makeConstraints { make in
            make.height.width.equalTo(30)
        }
        
        return button
    }
    
    func disable() {
        setTitleColor(.Custom.gray5, for: .normal)
        layer.borderColor = UIColor.Custom.gray5.cgColor
        isEnabled = false
    }
    
    func enable() {
        setTitleColor(.Custom.gray1, for: .normal)
        layer.borderColor = UIColor.Custom.gray1.cgColor
        isEnabled = true
    }
    
}

// MARK: - Providing Function

extension AgeCountStackView {
    
    func bindLoadedCount(_ value: @escaping (Int) -> Void) {
        viewModel?.loadedCount.bind(onNext: value)
    }
    
}
