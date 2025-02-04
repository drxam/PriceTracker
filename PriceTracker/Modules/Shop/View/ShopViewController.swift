//
//  ShopViewController.swift
//  PriceTracker
//
//  Created by dread on 15.01.2025.
//

import UIKit

final class ShopViewController: UIViewController, ShopDisplayLogic {
    let shopView = ShopView()
    var router: ShopRouterProtocol?
    var interactor: ShopBusinessLogic?
    
    var selectedIndex: IndexPath = IndexPath(item: 0, section: 0)
    var currentCategoryId: String = ""
    var currentCategoryIndex: Int = 0
    var shopType: ShopType = ShopType.magnit
    var categoriesName: [CategoryModel] = []
    
    var currentPage = 0
    let pageSize = 10
    var displayedProductsMagnit: [MagnitProductViewModel] = []
    var displayedProductsPaterochka: [PaterochkaProductViewModel] = []
    
    override func loadView() {
        view = shopView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        print(TotalData.magnitAll.count)
    }
    
    func configureShopType(_ shopType: ShopType) {
        self.shopType = shopType
        shopView.configureShopType(shopType)
        interactor?.fetchCategories(for: shopType)
        interactor?.fetchProducts(for: shopType)
    }
    
    func displayCategories(_ categories: [CategoryModel]) {
        self.categoriesName = categories
        currentCategoryId = categories[0].id ?? ""
        shopView.categories.reloadData()
    }
    
    func displayMagnit(_ categories: [MagnitCategoryViewModel]) {
        interactor?.fetchProductsForCategory(for: shopType, with: categoriesName[selectedIndex.row].id!)
    }
    
    func displayPaterochka(_ categories: [PaterochkaCategoryViewModel]) {
        interactor?.fetchProductsForCategory(for: shopType, with: categoriesName[selectedIndex.row].id!)
    }
    
    func displayMagnitCategory(_ index: Int) {
        currentCategoryIndex = index
        displayedProductsMagnit.removeAll()
        currentPage = 0
        loadMoreProducts()
        
        shopView.goods.reloadData()
    }
    
    func displayPaterochkaCategory(_ index: Int) {
        currentCategoryIndex = index
        displayedProductsPaterochka.removeAll()
        currentPage = 0
        loadMoreProducts()
        
        shopView.goods.reloadData()
    }
    
    func loadMoreProducts() {
        switch shopType {
        case .okey:
            print(4)
            
        case .perekrestok:
            print(4)
            
        case .paterochka:
            guard currentCategoryIndex < TotalData.paterochkaAll.count else { return }
            let allProducts = TotalData.paterochkaAll[currentCategoryIndex].products
            
            let startIndex = currentPage * pageSize
            let endIndex = min(startIndex + pageSize, allProducts.count)

            guard startIndex < endIndex else { return }

            let newProducts = Array(allProducts[startIndex..<endIndex])
            displayedProductsPaterochka.append(contentsOf: newProducts)
            currentPage += 1
            
        case .magnit:
            guard currentCategoryIndex < TotalData.magnitAll.count else { return }
            let allProducts = TotalData.magnitAll[currentCategoryIndex].products
            
            let startIndex = currentPage * pageSize
            let endIndex = min(startIndex + pageSize, allProducts.count)

            guard startIndex < endIndex else { return }

            let newProducts = Array(allProducts[startIndex..<endIndex])
            displayedProductsMagnit.append(contentsOf: newProducts)
            currentPage += 1
        }

        shopView.goods.reloadData()
    }
    
    private func configure() {
        congifureCategories()
        configureGoods()
        configureButtons()
        loadMoreProducts()
    }
    
    private func congifureCategories() {
        shopView.categories.delegate = self
        shopView.categories.dataSource = self
        shopView.categories.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseId)
        shopView.categories.selectItem(at: selectedIndex, animated: false, scrollPosition: .centeredHorizontally)
    }
    
    private func configureGoods() {
        shopView.goods.delegate = self
        shopView.goods.dataSource = self
        shopView.goods.register(ShopGoodsCell.self, forCellReuseIdentifier: ShopGoodsCell.reuseId)
    }
    
    private func configureButtons() {
        shopView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        shopView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        displayedProductsMagnit = []
        router?.dismissShopScreen()
    }
    
    @objc private func searchButtonTapped() {
        router?.showSearchScreen()
    }
}
