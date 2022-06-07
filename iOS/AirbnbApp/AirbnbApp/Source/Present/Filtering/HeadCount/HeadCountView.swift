//
//  HeadCountView.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/04.
//

import SnapKit
import UIKit

class TotalCountViewModel {
    
    var totalGuestCount = BehaviorRelay(value: 0)
    
    var loadAdultCount = BehaviorRelay(value: 0)
    var loadKidCount = BehaviorRelay(value: 0)
    var loadToddlerCount = BehaviorRelay(value: 0)
    
    init() {
        loadAdultCount.bind { [weak self] count in
            guard let self = self else { return }
            let totalCount = self.loadKidCount.value + count
            self.totalGuestCount.accept(totalCount)
        }
        
        loadKidCount.bind { [weak self] count in
            guard let self = self else { return }
            let totalCount = self.loadAdultCount.value + count
            self.totalGuestCount.accept(totalCount)
        }
        
        loadToddlerCount.bind { [weak self] count in
        }
        
        totalGuestCount.bind { [weak self] count in
            guard let totalCount = self?.totalGuestCount.value else { return }
        }
    }
    
}

class CountViewModel {
    
    var disablePlus = PublishRelay<Void>()
    var enablePlus = PublishRelay<Void>()
    
    var disableMinus = PublishRelay<Void>()
    var enableMinus = PublishRelay<Void>()
    
    var inputCountValue = PublishRelay<Int>()
    
    var loadCount = PublishRelay<Void>()
    var loadedCount = BehaviorRelay(value: 0)
    
    init() {
        
        loadedCount.bind { [weak self] currentValue in
            guard let self = self else { return }
            if currentValue == 0 {
                self.disableMinus.accept(())
            } else if currentValue == 8 {
                self.disablePlus.accept(())
            } else {
                self.enablePlus.accept(())
                self.enableMinus.accept(())
            }
        }
        
        loadCount.bind { [weak self] in
            guard let self = self else { return }
            self.loadedCount.accept(self.loadedCount.value)
        }
        
        inputCountValue.bind { [weak self] value in
            guard let currentCount = self?.loadedCount.value else { return }
            let resultCount = currentCount + value
            self?.loadedCount.accept(resultCount)
        }
    }
    
}

class HeadCountView: UIView {
    
    let totalCountViewModel = TotalCountViewModel()
        
    private lazy var adultCountStackView = AgeCountStackView()
    private lazy var kidCountStackView = AgeCountStackView()
    private lazy var toddlerCountStackView = AgeCountStackView()
    private lazy var countStackViews = [adultCountStackView, kidCountStackView, toddlerCountStackView]
    
    private lazy var ageGroupContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .equalSpacing
        
        Age.allCases.enumerated().forEach { (index, age) in
            let ageLabelStackView = UIStackView.makeAgeLabel(title: age.title, description: age.description)
            let ageCountStackView = countStackViews[index]
            let ageGroupView = UIView.makeAgeGroup(labelStackView: ageLabelStackView,
                                                   countStackView: ageCountStackView)
            stackView.addArrangedSubview(ageGroupView)
        }
        stackView.insertArrangedSubview(UIView.makeSeparater(), at: 1)
        stackView.insertArrangedSubview(UIView.makeSeparater(), at: 3) // 더 좋은 방법 없으려나
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutAgeGroupContainerStackView()
        
        let totalCountViewModel = TotalCountViewModel()
        
        adultCountStackView.configure(viewModel: CountViewModel())
        kidCountStackView.configure(viewModel: CountViewModel())
        toddlerCountStackView.configure(viewModel: CountViewModel())
        
        adultCountStackView.bindLoadedCount { value in
            totalCountViewModel.loadAdultCount.accept(value)
        }
        
        kidCountStackView.bindLoadedCount { value in
            totalCountViewModel.loadKidCount.accept(value)
        }
        
        toddlerCountStackView.bindLoadedCount { value in
            totalCountViewModel.loadToddlerCount.accept(value)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutAgeGroupContainerStackView()
    }
    
}

// MARK: - View Layout

private extension HeadCountView {
    
    func layoutAgeGroupContainerStackView() {
        addSubview(ageGroupContainerStackView)
        
        ageGroupContainerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

// MARK: - Private Extension

private extension UILabel {
    
    static func makeAgeGroup(title: String, description: String) -> [UILabel] {
        let titleLabel = CustomLabel(text: title,
                                     font: .boldSystemFont(ofSize: 17),
                                     fontColor: .Custom.gray1)
        let descriptionLabel = CustomLabel(text: description,
                                           font: .systemFont(ofSize: 17),
                                           fontColor: .Custom.gray3)
        
        return [titleLabel, descriptionLabel]
    }
    
}

private extension UIStackView {
    
    static func makeAgeLabel(title: String, description: String) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalSpacing
        
        let labels = UILabel.makeAgeGroup(title: title, description: description)
        labels.forEach { label in
            stackView.addArrangedSubview(label)
        }
        
        return stackView
    }
}

private extension UIView {
    
    static func makeSeparater() -> UIView {
        let view = UIView()
        view.backgroundColor = .Custom.gray5
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        return view
    }
    
    static func makeAgeGroup(labelStackView: UIStackView, countStackView: UIStackView) -> UIView {
        let view = UIView()
        view.addSubview(labelStackView)
        view.addSubview(countStackView)
        
        labelStackView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
        }
        
        countStackView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(labelStackView)
        }
        
        return view
    }
    
}
