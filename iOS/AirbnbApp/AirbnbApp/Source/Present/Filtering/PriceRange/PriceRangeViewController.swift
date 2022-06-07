//
//  PriceRangeViewController.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/02.
//

import SnapKit
import UIKit

class PriceRangeViewController: UIViewController {
    
    private let viewModel: PriceRangeViewModel
    
    private lazy var priceRangeLabel = CustomLabel(text: "가격 범위",
                                                   font: .SFProDisplay.semiBold,
                                                   fontColor: .Custom.gray1)
    
    private lazy var minPriceLabel = CustomLabel(text: "₩100,000",
                                                 font: .SFProDisplay.semiBold,
                                                 fontColor: .Custom.gray1)
    
    private lazy var separaterLabel = CustomLabel(text: "-",
                                                  font: .SFProDisplay.semiBold,
                                                  fontColor: .Custom.gray1)
    
    private lazy var maxPriceLabel = CustomLabel(text: "₩1,000,000+",
                                                 font: .SFProDisplay.semiBold,
                                                 fontColor: .Custom.gray1)
    
    private lazy var priceRangeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        minPriceLabel.numberOfLines = 1
        [minPriceLabel, separaterLabel, maxPriceLabel].forEach { subView in
            stackView.addArrangedSubview(subView)
        }
        return stackView
    }()
    
    private let averagePriceLabel = CustomLabel(text: "평균 1박 요금은 ₩165,556 입니다.",
                                                font: .SFProDisplay.semiBold,
                                                fontColor: .Custom.gray3)
    
    init(viewModel: PriceRangeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutPriceRangeLabel()
        layoutPriceRangeStackView()
        layoutAveragePriceLabel()
        bind()
        
    }
    
    private func bind() {
        viewModel.loadedState.bind { priceRange in
        }
        
        viewModel.loadAction.accept(())
    }
}

// MARK: - View Layout

private extension PriceRangeViewController {
    
    func layoutPriceRangeLabel() {
        view.addSubview(priceRangeLabel)
        
        priceRangeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.leading.equalToSuperview().offset(16)
        }
        
    }
    
    func layoutPriceRangeStackView() {
        
        view.addSubview(priceRangeStackView)
        
        priceRangeStackView.snp.makeConstraints { make in
            make.top.equalTo(priceRangeLabel.snp.bottom).offset(16)
            make.leading.equalTo(priceRangeLabel)
        }
    }
    
    func layoutAveragePriceLabel() {
        view.addSubview(averagePriceLabel)
        
        averagePriceLabel.snp.makeConstraints { make in
            make.top.equalTo(priceRangeStackView.snp.bottom).offset(8)
            make.leading.equalTo(priceRangeLabel)
        }
    }
    
}
