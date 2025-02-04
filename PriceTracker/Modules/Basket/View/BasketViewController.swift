//
//  BasketViewController.swift
//  PriceTracker
//
//  Created by dread on 14.01.2025.
//

import UIKit

final class BasketViewController: UIViewController {
    let basketView = BasketView()
    var router: BasketRouterProtocol?
    
    var productsOkey: [ProductModel] = []
    var productsPerekrestok: [ProductModel] = []
    var productsMagnit: [ProductModel] = []
    var productsPaterochka: [ProductModel] = []
    
    override func loadView() {
        view = basketView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func receiveProducts() {
        
    }
    
    private func configure() {
        configureTables()
        
        basketView.clearButton.addTarget(self, action: #selector(clearBasket), for: .touchUpInside)
    }
    
    private func configureTables() {
        configureTable(basketView.table1)
        configureTable(basketView.table2)
        configureTable(basketView.table3)
        configureTable(basketView.table4)
    }
    
    private func configureTable(_ table: UITableView) {
        table.delegate = self
        table.dataSource = self
        table.register(BasketViewCell.self, forCellReuseIdentifier: BasketViewCell.reuseId)
    }
    
    private func confirmClear() {
        
    }
    
    @objc private func clearBasket() {
        router?.showAlert(title: "Вы уверены, что хотите очистить корзину?", confirmTitle: "Очистить", cancelTitle: "Отмена", onConfirm: confirmClear)
    }
}
