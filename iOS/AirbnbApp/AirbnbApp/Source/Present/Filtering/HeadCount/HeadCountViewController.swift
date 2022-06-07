//
//  HeadCountViewController.swift
//  AirbnbApp
//
//  Created by 김상혁 on 2022/06/05.
//

import SnapKit
import UIKit

class HeadCountViewController: UIViewController {
    
    private let headCountView = HeadCountView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headCountView)
        
        headCountView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
}
