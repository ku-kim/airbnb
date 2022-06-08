//
//  CityViewCell.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/23.
//

import UIKit
import SnapKit

final class CityViewCell: UICollectionViewCell, ViewCellBindable {
    
    static var identifier: String {
        return "\(self)"
    }
    
    private var viewModel: CellViewModelable?
    
    @NetworkInject(keypath: \.imageManager)
    private var imageManager: ImageManager
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var titleLabel = CustomLabel(font: .SFProDisplay.semiBold,
                                                  fontColor: .Custom.gray1)
    
    private lazy var distanceLabel = CustomLabel(font: .SFProDisplay.regular(17),
                                                 fontColor: .Custom.gray3)
    
    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 4
        [titleLabel, distanceLabel].forEach { subview in
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
        super.init(coder: coder)
        layoutCityImageView()
        layoutInformationStackView()
    }

}

// MARK: - View Layout

private extension CityViewCell {
    
    func layoutCityImageView() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(imageView.snp.height)
        }
    }
    
    func layoutInformationStackView() {
        addSubview(informationStackView)
        
        informationStackView.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(imageView.snp.centerY)
        }
    }
    
}

// MARK: - Providing Function

extension CityViewCell {
    
    func configure(with viewModel: CellViewModelable) {
        self.viewModel = viewModel
        guard let viewModel = self.viewModel as? CityCellViewModel else { return }
        
        viewModel.loadedCityName.bind { [ weak self ] title in
            self?.titleLabel.text = title
        }
        
        viewModel.loadedCityImage.bind { [ weak self ] imageUrl in
            let imageUrl = URL(string: imageUrl)
            self?.imageManager.fetchImage(from: imageUrl) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
        
        viewModel.loadedTime.bind { [ weak self ] time in
            self?.distanceLabel.text = "차로 \(time.convertIntoTime()) 거리"
        }
        
        viewModel.loadCityData.accept(())
        viewModel.disposeBind()
    }
    
}
