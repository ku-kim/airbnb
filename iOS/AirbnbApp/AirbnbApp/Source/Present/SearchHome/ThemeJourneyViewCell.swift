//
//  ThemeJourneyViewCell.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/24.
//

import UIKit
import SnapKit

class ThemeJourneyCellViewModel: SearchHomeCellViewModel {
    private let theme: SearchHomeEntity.Theme
    
    init(theme: SearchHomeEntity.Theme) {
        self.theme = theme
    }
    
    func getTheme() -> SearchHomeEntity.Theme {
        return theme
    }
}

final class ThemeJourneyViewCell: UICollectionViewCell, SearhHomeCellView {
    
    @NetworkInject(keypath: \.imageManager)
    private var imageManager: ImageManager
    
    func setViewModel(_ viewModel: SearchHomeCellViewModel) {
        
        guard let viewModel = viewModel as? ThemeJourneyCellViewModel else { return }
        let theme = viewModel.getTheme()
        
        
        let imageUrl = URL(string: theme.imageUrl)
        imageManager.fetchImage(from: imageUrl) { [weak self] image in
            DispatchQueue.main.async {
                self?.setImageView(image: image ?? UIImage())
                // TODO: image가 nil일 경우 handling하는 에러 구현하기
            }
        }
        
        setDescriptionLabel(text: theme.title)
    }
    static var identifier: String {
        return "\(self)"
    }
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var descriptionLabel = CustomLabel(font: .NotoSans.medium,
                                                    fontColor: .Custom.gray1)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutImageView()
        layoutDescriptionLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutImageView()
        layoutDescriptionLabel()
    }
}

// MARK: - View Layout

private extension ThemeJourneyViewCell {
    
    func layoutImageView() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.82)
        }
    }
    
    func layoutDescriptionLabel() {
        addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
    }
    
}

// MARK: - Providing Function

extension ThemeJourneyViewCell {
    
    func setImageView(image: UIImage) {
        imageView.image = image
    }
    
    func setDescriptionLabel(text: String) {
        descriptionLabel.text = text
    }
    
    func configureCell(with theme: SearchHomeEntity.Theme) {
//        let imageUrl = URL(string: theme.imageUrl)
//        imageManager.fetchImage(from: imageUrl) { image in
//            DispatchQueue.main.async {
//                setImageView(image: image ?? UIImage())
//                // TODO: image가 nil일 경우 handling하는 에러 구현하기
//            }
//        }
//        
//        setDescriptionLabel(text: theme.title)
    }
}


protocol CellConfigurable {
//    func configureCell(with: Cellable)
}
