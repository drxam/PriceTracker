//
//  MainViewController.swift
//  PriceTracker
//
//  Created by dread on 24.12.2024.
//

import UIKit

final class MainViewController: UIViewController, MainDisplayLogic, MainGoodsCellDelegate {
    var mainView = MainView()
    var router: MainRouterProtocol?
    var interactor: MainBusinessLogic?
    
    var displayedProducts: [ProductModel] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        interactor?.loadMoreProducts()
    }
    
    func displayProducts(_ products: [ProductModel]) {
        displayedProducts.append(contentsOf: products)
        
        updateTableHeight()
        mainView.goodsTable.reloadData()
        mainView.scrollView.layoutIfNeeded()
    }
    
    private func updateTableHeight() {
        let numberOfItems = displayedProducts.count
        let rows = ceil(Double(numberOfItems) / 2.0)
        let itemHeight: CGFloat = 260
        let spacing: CGFloat = 15
        let totalHeight = CGFloat(rows) * itemHeight + CGFloat(rows - 1) * spacing

        mainView.goodsTable.invalidateIntrinsicContentSize()
        mainView.goodsTable.layoutIfNeeded()

        mainView.scrollView.layoutIfNeeded()
        let wrapHeight = totalHeight + 40 + 15
//        if let constraint = mainView.goodsWrap.constraints.first(where: { $0.firstAttribute == .height }) {
//            constraint.isActive = false
//        }
        NSLayoutConstraint.deactivate(mainView.goodsWrap.constraints.filter { $0.firstAttribute == .height })

        mainView.goodsWrap.setHeight(wrapHeight)

        mainView.scrollView.contentSize = CGSize(
            width: mainView.scrollView.frame.width,
            height: mainView.goodsWrap.frame.maxY
        )
    }
    
    private func configure() {
        mainView.goodsTable.delegate = self
        mainView.goodsTable.dataSource = self
        mainView.goodsTable.register(MainGoodsCell.self, forCellWithReuseIdentifier: MainGoodsCell.reuseId)
        
        mainView.scrollView.delegate = self
        mainView.searchText.delegate = self
        
        mainView.shops[0].addTarget(self, action: #selector(buttonTapped1), for: .touchUpInside)
        mainView.shops[1].addTarget(self, action: #selector(buttonTapped2), for: .touchUpInside)
        mainView.shops[2].addTarget(self, action: #selector(buttonTapped3), for: .touchUpInside)
        mainView.shops[3].addTarget(self, action: #selector(buttonTapped4), for: .touchUpInside)
    }
    
    func didTapAddButton(for product: ProductModel?) {
        interactor?.plusButtonTapped(for: product)
    }
    
    @objc private func buttonTapped1() {
        router?.showShopScreen(with: ShopType.paterochka)
    }
    
    @objc private func buttonTapped2() {
        router?.showShopScreen(with: ShopType.okey)
    }
    
    @objc private func buttonTapped3() {
        router?.showShopScreen(with: ShopType.perekrestok)
    }
    
    @objc private func buttonTapped4() {
        router?.showShopScreen(with: ShopType.magnit)
    }
}
