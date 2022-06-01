//
//  CityViewCell.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/05/23.
//

import UIKit
import SnapKit

class CityCellViewModel: SearchHomeCellViewModel {
    private let city: SearchHomeEntity.City
    
    init(city: SearchHomeEntity.City) {
        self.city = city
    }
    
    func getCity() -> SearchHomeEntity.City {
        return city
    }
}

final class CityViewCell: UICollectionViewCell, SearhHomeCellView {
    
    @NetworkInject(keypath: \.imageManager)
    private var imageManager: ImageManager
    
    func setViewModel(_ viewModel: SearchHomeCellViewModel) {
        
        guard let viewModel = viewModel as? CityCellViewModel else { return }
        let city = viewModel.getCity()
        
        let imageUrl = URL(string: city.imageUrl)
        imageManager.fetchImage(from: imageUrl) { [weak self] image in
            DispatchQueue.main.async {
                self?.setCityImageView(image: image ?? UIImage())
                // TODO: image가 nil일 경우 handling하는 에러 구현하기
            }
        }
        
        setCityTitleLabel(text: city.cityName)
        setDistanceLabel(text: city.time.convertIntoTime())
    }
    
    static var identifier: String {
        return "\(self)"
    }
    
    private lazy var cityImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var cityTitleLabel = CustomLabel(font: .SFProDisplay.semiBold,
                                                  fontColor: .Custom.gray1)
    
    private lazy var distanceLabel = CustomLabel(text: "차로 30분 거리",
                                                 font: .SFProDisplay.regular(17),
                                                 fontColor: .Custom.gray3)
    
    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 4
        [cityTitleLabel, distanceLabel].forEach { subview in
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
        addSubview(cityImageView)
        
        cityImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(cityImageView.snp.height)
        }
    }
    
    func layoutInformationStackView() {
        addSubview(informationStackView)
        
        informationStackView.snp.makeConstraints { make in
            make.leading.equalTo(cityImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(cityImageView.snp.centerY)
        }
    }
    
}

// MARK: - Providing Function

extension CityViewCell {
    
    func setCityImageView(image: UIImage) {
        cityImageView.image = image
    }
    
    func setCityTitleLabel(text: String) {
        cityTitleLabel.text = text
    }
    
    func setDistanceLabel(text: String) {
        distanceLabel.text = "차로 \(text) 거리"
    }
}
