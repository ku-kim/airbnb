//
//  HeadCountViewController.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/05.
//

import SnapKit
import UIKit

final class HeadCountViewController: FilteringConditionViewController {
    
    private let itemStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let viewModel: HeadCountViewModel?
    
    init(viewModel: HeadCountViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        layoutItemStackView()
    }
    
    private func bind() {
        viewModel?.loadedItemViewModel.bind { [weak self] itemViewModels in
            itemViewModels.forEach { itemViewModel in
                let itemView = HeadCountItemView(viewModel: itemViewModel)
                self?.itemStackView.addArrangedSubview(itemView)
            }
        }
        
        viewModel?.loadItemViewModel.accept(())
    }
    
}

// MARK: - View Layout

private extension HeadCountViewController {
    
    func layoutItemStackView() {
        view.addSubview(itemStackView)
        
        itemStackView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
    
}
