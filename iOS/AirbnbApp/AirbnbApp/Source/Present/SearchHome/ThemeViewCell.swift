//
//  ThemeViewCell.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/24.
//

import UIKit
import SnapKit

final class ThemeViewCell: UICollectionViewCell, ViewCellBindable {
    
    static var identifier: String {
        return "\(self)"
    }
    
    private var viewModel: CellViewModelable?
    
    @NetworkInject(keypath: \.imageManager)
    private var imageManager: ImageManager
    
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

private extension ThemeViewCell {
    
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

extension ThemeViewCell {
    
    func configure(with viewModel: CellViewModelable) {
        self.viewModel = viewModel
        guard let viewModel = self.viewModel as? ThemeCellViewModel else { return }
        
        viewModel.loadedThemeName.bind { [ weak self ] description in
            self?.descriptionLabel.text = description
        }
        
        viewModel.loadedThemeImage.bind { [ weak self ] imageUrl in
            let imageUrl = URL(string: imageUrl)
            self?.imageManager.fetchImage(from: imageUrl) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
        
        viewModel.loadThemeData.accept(())
    }
    
}
