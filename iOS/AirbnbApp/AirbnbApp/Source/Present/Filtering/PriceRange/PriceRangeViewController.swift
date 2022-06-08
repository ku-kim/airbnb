//
//  PriceRangeViewController.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/02.
//

import SnapKit
import UIKit

class PriceRangeViewController: UIViewController {
    
    private let viewModel = PriceRangeViewModel()
    
    private lazy var priceRangeLabel = CustomLabel(text: .PriceRange.priceRangeLabel,
                                                   font: .SFProDisplay.semiBold,
                                                   fontColor: .Custom.gray1)
    
    private lazy var minPriceLabel = CustomLabel(text: "₩100,000",
                                                 font: .SFProDisplay.semiBold,
                                                 fontColor: .Custom.gray1)
    
    private lazy var separaterLabel = CustomLabel(text: .PriceRange.separaterLabel,
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
    
    private lazy var averagePriceLabel = CustomLabel(font: .SFProDisplay.semiBold,
                                                     fontColor: .Custom.gray3)
    
    private lazy var histogram: HistogramView = {
        let histogram = HistogramView()
        histogram.backgroundColor = .clear
        return histogram
    }()
    
    private lazy var histogramBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .Custom.gray4
        return view
    }()
    
    private lazy var histogramForegroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .Custom.gray3
        return view
    }()
    
    private lazy var slider: CustomSlider = {
        let slider = CustomSlider()
        slider.minValue = 0
        slider.maxValue = 1
        slider.lower = 0
        slider.upper = 1
        slider.addTarget(self, action: #selector(changeValue), for: .valueChanged)
        return slider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        
        layoutPriceRangeLabel()
        layoutPriceRangeStackView()
        layoutAveragePriceLabel()
        layoutHistogram()
        layoutHistogramBackgroundView()
        layoutHistogramForegroundView()
        layoutSlider()
    }
    
    private func bind() {
        viewModel.loadedState.bind { [ weak self ] priceRange in
            self?.averagePriceLabel.text = "평균 1박 요금은 ₩\(priceRange.averagePrice) 입니다."
            guard let max = priceRange.histogram.max() else { return }
            let maxCount: CGFloat = CGFloat(max.count)
            var points: [CGPoint] = []
            let count = priceRange.histogram.count
            
            priceRange.histogram.enumerated().forEach { index, histogram in
                let point = CGPoint(x: CGFloat(index) / CGFloat(count), y: CGFloat(histogram.count)/maxCount)
                points.append(point)
            }
            self?.histogram.setPath(points: points)
        }
        
        viewModel.loadAction.accept(())
    }
}

// MARK: - Selector Function

private extension PriceRangeViewController {
    
    @objc private func changeValue() {
        let width = histogram.frame.width
        histogramForegroundView.snp.updateConstraints { make in
            make.leading.equalToSuperview().offset(width * slider.lower)
            make.trailing.equalToSuperview().inset(width * (1 - slider.upper))
        }
    }
    
}

// MARK: - View Layout

private extension PriceRangeViewController {
    
    func layoutPriceRangeLabel() {
        view.addSubview(priceRangeLabel)
        
        priceRangeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.leading.equalToSuperview()
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
    
    func layoutHistogram() {
        view.addSubview(histogram)
        
        histogram.snp.makeConstraints { make in
            make.top.equalTo(averagePriceLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func layoutHistogramBackgroundView() {
        histogram.addSubview(histogramBackgroundView)
        
        histogramBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func layoutHistogramForegroundView() {
        histogram.addSubview(histogramForegroundView)
        
        histogramForegroundView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
    
    func layoutSlider() {
        view.addSubview(slider)
        
        slider.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalToSuperview()
            make.centerY.equalTo(histogram.snp.bottom)
        }
    }
    
}
