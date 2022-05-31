//
//  FilteringViewController.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/31.
//

import UIKit
import MapKit

class FilteringViewController: UIViewController {
    
    private let location: MKLocalSearchCompletion
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    init(location: MKLocalSearchCompletion) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
