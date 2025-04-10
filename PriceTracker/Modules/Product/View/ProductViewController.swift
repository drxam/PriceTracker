//
//  ProductViewController.swift
//  PriceTracker
//
//  Created by dread on 18.01.2025.
//

import UIKit

final class ProductViewController: UIViewController, ProductDisplayLogic {
    let productView = ProductView()
    var interactor: ProductBusinessLogic?
    var router: ProductRouterProtocol?
    
    var product: ProductModel?
    
    override func loadView() {
        view = productView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure(shop: ShopType, category: String, productId: String) {
        interactor?.fetchProduct(from: shop, category: category, productId: productId)
    }
    
    func displayProduct(product: PaterochkaProduct) {
        productView.configure(with: product)
    }
    
    func displayProduct(product: MagnitProduct) {
        productView.configure(with: product)
    }
    
    func setProduct(product: ProductModel) {
        self.product = product
    }
    
    private func configure() {
        productView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        productView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        router?.dismissProductScreen()
    }
    
    @objc private func plusButtonTapped() {
        interactor?.plusButtonTapped(for: product)
    }
}
