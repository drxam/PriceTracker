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
    
    func displayPaterochka(product: PaterochkaProduct) {
        productView.configurePaterochka(with: product)
    }
    
    func displayMagnit(product: MagnitProduct) {
        productView.configureMagnit(with: product)
    }
    
    func displayPerekrestok(product: PaterochkaProduct) {
        productView.configurePerekrestok(with: product)
    }
    
    func displayOkey(product: MagnitProduct) {
        productView.configureOkey(with: product)
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
