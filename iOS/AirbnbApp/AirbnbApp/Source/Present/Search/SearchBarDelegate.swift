//
//  FooSearchBarDelegate.swift
//  AirbnbApp
//
//  Created by dale on 2022/05/29.
//

import UIKit
import MapKit

class SearchBarDelegate: NSObject, UISearchBarDelegate {
    
    private var searchCompleter = MKLocalSearchCompleter()
    
    private let editTextField = PublishRelay<[MKLocalSearchCompletion]>()
    private let dismissTextField = PublishRelay<Void>()
    
    override init() {
        super.init()
        setupSearchCompleter()
    }
    
    private func setupSearchCompleter() {
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .query
    }
    
}

extension SearchBarDelegate: MKLocalSearchCompleterDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            dismissTextField.accept(())
            return
        }
        searchCompleter.queryFragment = searchText
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        editTextField.accept(completer.results)
    }
    
    func bindEditTextField(_ completion: @escaping ([MKLocalSearchCompletion]) -> Void) {
        editTextField.bind(onNext: completion)
    }
    
    func bindDismissTextField(_ completion: @escaping () -> Void) {
        dismissTextField.bind(onNext: completion)
    }
    
}
