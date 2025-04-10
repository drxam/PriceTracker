//
//  BasketViewController.swift
//  PriceTracker
//
//  Created by dread on 14.01.2025.
//

import UIKit

final class BasketViewController: UIViewController, BasketDisplayLogic, BasketViewCellDelegate, BasketViewDelegate {
    let basketView = BasketView()
    var interactor: BasketBusinessLogic?
    var router: BasketRouterProtocol?
    
    var productsByShop: [ShopType: [ProductModel?: Int]] = [
        .okey: [:],
        .perekrestok: [:],
        .paterochka: [:],
        .magnit: [:]
    ]
    
    lazy var tableToShop: [UITableView: ShopType] = [
        basketView.table1: .okey,
        basketView.table2: .perekrestok,
        basketView.table3: .paterochka,
        basketView.table4: .magnit
    ]
    
    override func loadView() {
        basketView.delegate = self
        view = basketView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configureNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(receiveProduct(_:)), name: NSNotification.Name("AddNewItem"), object: nil)
    }
    
    func updateAllPrices(_ prices: [ShopType: String], _ oldPrices: [ShopType: String]) {
        let price1 = prices[ShopType.okey]
        let price2 = prices[ShopType.perekrestok]
        let price3 = prices[ShopType.paterochka]
        let price4 = prices[ShopType.magnit]
        basketView.price1.text = price1
        basketView.price2.text = price2
        basketView.price3.text = price3
        basketView.price4.text = price4
        
        let oldPrice1 = oldPrices[ShopType.okey]
        let oldPrice2 = oldPrices[ShopType.perekrestok]
        let oldPrice3 = oldPrices[ShopType.paterochka]
        let oldPrice4 = oldPrices[ShopType.magnit]
        
        setStrikethroughText(for: basketView.oldPrice1, oldPrice: oldPrice1, price: price1)
        setStrikethroughText(for: basketView.oldPrice2, oldPrice: oldPrice2, price: price2)
        setStrikethroughText(for: basketView.oldPrice3, oldPrice: oldPrice3, price: price3)
        setStrikethroughText(for: basketView.oldPrice4, oldPrice: oldPrice4, price: price4)
        
        rearrangeStackView()
    }
    
    func displayNewProducts(_ products: [ShopType: ProductModel?]) {
        for (shop, product) in products {
            if productsByShop[shop]?[product] != nil {
                productsByShop[shop]?[product]? += 1
            } else {
                productsByShop[shop]?[product] = 1
            }
        }
        updateTables()
        interactor?.updateAllPrices(productsByShop)
    }
    
    func didTapPlusButton(_ product: String) {
        if let updatedData = interactor?.changeCount(product, productsByShop, 1) {
            productsByShop = updatedData
        }
        updateTables()
        interactor?.updateAllPrices(productsByShop)
    }
    
    func didTapMinusButton(_ product: String) {
        if let updatedData = interactor?.changeCount(product, productsByShop, -1) {
            productsByShop = updatedData
        }
        updateTables()
        interactor?.updateAllPrices(productsByShop)
    }
    
    func getProductsCount() -> Int {
        return productsByShop[ShopType.magnit]?.isEmpty ?? true ? 1 : productsByShop[ShopType.magnit]?.count ?? 1
    }
    
    private func configure() {
        configureTables()
        configureButtons()
        
        basketView.clearButton.addTarget(self, action: #selector(clearBasket), for: .touchUpInside)
    }
    
    private func setStrikethroughText(for label: UILabel, oldPrice: String?, price: String?) {
        let attributedString = oldPrice != price ? NSAttributedString(
            string: oldPrice ?? "",
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
        ) : NSAttributedString(string: "")
        
        label.attributedText = attributedString
    }

    private func rearrangeStackView() {
        let arrangedSubviews = basketView.stack.arrangedSubviews
        
        for view in arrangedSubviews {
            basketView.stack.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        let newViews = interactor?.rearrangeStackView([basketView.okey, basketView.perekrestok, basketView.paterochka, basketView.magnit], [basketView.price1.text ?? "", basketView.price2.text ?? "", basketView.price3.text ?? "", basketView.price4.text ?? ""])
        
        if let res = newViews {
            for view in res {
                basketView.stack.addArrangedSubview(view)
            }
        }
    }
    
    private func configureTables() {
        configureTable(basketView.table1)
        configureTable(basketView.table2)
        configureTable(basketView.table3)
        configureTable(basketView.table4)
    }
    
    private func configureButtons() {
        basketView.button1.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        basketView.button2.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        basketView.button3.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        basketView.button4.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
    }
    
    private func configureTable(_ table: UITableView) {
        table.delegate = self
        table.dataSource = self
        table.register(BasketViewCell.self, forCellReuseIdentifier: BasketViewCell.reuseId)
        table.register(EmptyViewCell.self, forCellReuseIdentifier: EmptyViewCell.reuseId)
    }
    
    private func updateTables() {
        basketView.table1.reloadData()
        basketView.table2.reloadData()
        basketView.table3.reloadData()
        basketView.table4.reloadData()
        basketView.updateTableHeight()
    }
    
    private func confirmClear() {
        productsByShop = [
            .okey: [:],
            .perekrestok: [:],
            .paterochka: [:],
            .magnit: [:]
        ]
        updateTables()
        interactor?.updateAllPrices(productsByShop)
    }
    
    @objc private func clearBasket() {
        router?.showAlert(title: "Вы уверены, что хотите очистить корзину?", confirmTitle: "Очистить", cancelTitle: "Отмена", onConfirm: confirmClear)
    }
    
    @objc private func receiveProduct(_ notification: Notification) {
        if let newItem = notification.object as? ProductModel {
            interactor?.addNewProduct(product: newItem)
            print("Добавлен новый элемент: \(newItem.name)")
        } else {
            print("Объект не добавлен: Пустой объект")
        }
    }
    
    @objc private func buyButtonTapped(_ button: UIButton) {
        switch button {
        case basketView.button1:
            interactor?.buyButtonTapped(basketView.price1.text ?? "", basketView.oldPrice1.text ?? "", productsByShop[.okey]?.compactMap { $0.value }.reduce(0, +) ?? 0)
        case basketView.button2:
            interactor?.buyButtonTapped(basketView.price2.text ?? "", basketView.oldPrice2.text ?? "", productsByShop[.perekrestok]?.compactMap { $0.value }.reduce(0, +) ?? 0)
        case basketView.button3:
            interactor?.buyButtonTapped(basketView.price3.text ?? "", basketView.oldPrice3.text ?? "", productsByShop[.paterochka]?.compactMap { $0.value }.reduce(0, +) ?? 0)
        case basketView.button4:
            interactor?.buyButtonTapped(basketView.price4.text ?? "", basketView.oldPrice4.text ?? "", productsByShop[.magnit]?.compactMap { $0.value }.reduce(0, +) ?? 0)
        default:
            print("")
        }
        confirmClear()
    }
}
