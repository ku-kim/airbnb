//
//  NextStepView.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/04.
//

import UIKit

final class NextStepView: UIView {
    
    private lazy var leftButton = UIButton.make(title: .NextStep.leftButtonTitle, color: .Custom.black)
    private lazy var rightButton = UIButton.make(title: .NextStep.rightButtonTitle, color: .Custom.gray4)
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        [leftButton, rightButton].forEach { button in
            stackView.addArrangedSubview(button)
        }
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutButtonStackView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        layoutButtonStackView()
    }
    
    private func configure() {
        backgroundColor = .Custom.gray6
    }
    
}

// MARK: - View Layout

private extension NextStepView {
    
    func layoutButtonStackView() {
        addSubview(buttonStackView)

        buttonStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
}

// MARK: - Private Extension

private extension UIButton {
    
    static func make(title: String, color: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .disabled)
        button.setTitleColor(.Custom.gray1, for: .normal)
        button.isEnabled = false
        
        button.addAction(UIAction(handler: { _ in
            // TODO: '다음'버튼 터치시 검색조건에 맞는 숙소 리스트 화면을 갖는 VC가 Push되도록 구현
        }), for: .touchUpInside)
        
        return button
    }
    
}
