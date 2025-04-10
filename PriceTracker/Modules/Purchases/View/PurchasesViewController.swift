//
//  PurchasesViewController.swift
//  PriceTracker
//
//  Created by dread on 25.12.2024.
//

import UIKit

final class PurchasesViewController: UIViewController, PurchasesDisplayLogic {
    let purchasesView = PurchasesView()
    var router: PurchasesRouterProtocol?
    var interactor: PurchasesBusinessLogic?
    
    override func loadView() {
        view = purchasesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        purchasesView.table.register(PurchasesViewCell.self, forCellReuseIdentifier: PurchasesViewCell.reuseId)
        purchasesView.table.delegate = self
        purchasesView.table.dataSource = self
        
        purchasesView.button.addTarget(self, action: #selector(showHistory), for: .touchUpInside)
    }
    
    func configureNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(receivePurchase(_:)), name: NSNotification.Name("AddNewPurchase"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clearPurchaseHistory(_:)), name: NSNotification.Name("ClearPurchaseHistory"), object: nil)
    }
    
    func displayPurchases(_ expenses: [String]) {
        purchasesView.allExpenses.text = expenses[0]
        purchasesView.allEconomy.text = expenses[1]
        purchasesView.monthExpenses.text = expenses[2]
        purchasesView.monthEconomy.text = expenses[3]
    }
    
    private func clearExpenses() {
        purchasesView.allExpenses.text = "0 ₽"
        purchasesView.allEconomy.text = "0 ₽"
        purchasesView.monthExpenses.text = "0 ₽"
        purchasesView.monthEconomy.text = "0 ₽"
    }
    
    @objc private func showHistory() {
        router?.presentHistoryScreen()
    }
    
    @objc private func receivePurchase(_ notification: Notification) {
        if let newItem = notification.object as? PurchaseModel {
            print("Добавлена новая покупка")
            interactor?.addNewPurchase(newItem)
            purchasesView.table.reloadData()
        } else {
            print("Объект не добавлен: Пустой объект")
        }
    }
    
    @objc private func clearPurchaseHistory(_ notification: Notification) {
        TotalData.purchases = []
        purchasesView.table.reloadData()
        clearExpenses()
    }
}
