//
//  SearchViewController.swift
//  PriceTracker
//
//  Created by dread on 19.01.2025.
//

import UIKit

final class SearchViewController: UIViewController {
    let searchView = SearchView()
    var router: SearchRouterProtocol?
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        searchView.searchText.delegate = self
        
        searchView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        router?.dismissSearchScreen()
    }
}
