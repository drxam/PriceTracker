//
//  SearchViewController.swift
//  PriceTracker
//
//  Created by dread on 19.01.2025.
//

import UIKit

final class SearchViewController: UIViewController, SearchDisplayLogic, SearchGoodsCellDelegate {
    let searchView = SearchView()
    var interactor: SearchBusinessLogic?
    var router: SearchRouterProtocol?
    
    var displayedProducts: [ProductModel] = []
    var shopType: ShopType? = nil
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearch()
    }
    
    func configure(_ query: String, _ shopType: ShopType?) {
        self.shopType = shopType
        if query != "" {
            displayedProducts = []
            interactor?.searchProducts(query, shopType)
            interactor?.loadMoreProducts()
            searchView.searchText.text = query
            searchView.searchText.textColor = .black
        }
    }
    
    func displayProducts(_ products: [ProductModel]) {
        displayedProducts.append(contentsOf: products)
        searchView.goods.reloadData()
    }
    
    func didTapAddButton(for product: ProductModel?) {
        interactor?.plusButtonTapped(for: product)
    }
    
    private func configureSearch() {
        searchView.searchText.delegate = self
        
        searchView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        searchView.goods.register(SearchGoodsCell.self, forCellReuseIdentifier: SearchGoodsCell.reuseId)
        searchView.goods.dataSource = self
        searchView.goods.delegate = self
    }
    
    @objc private func backButtonTapped() {
        router?.dismissSearchScreen()
    }
}
