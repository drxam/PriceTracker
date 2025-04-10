//
//  HistoryViewController.swift
//  PriceTracker
//
//  Created by dread on 14.01.2025.
//

import UIKit

final class HistoryViewController: UIViewController {
    let historyView = HistoryView()
    var router: HistoryRouterProtocol?
    
    override func loadView() {
        view = historyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configureNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(receivePurchase(_:)), name: NSNotification.Name("AddNewPurchase"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(clearPurchaseHistory(_:)), name: NSNotification.Name("ClearPurchaseHistory"), object: nil)
    }
    
    private func configure() {
        historyView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        historyView.tableView.delegate = self
        historyView.tableView.dataSource = self
        historyView.tableView.register(PurchasesViewCell.self, forCellReuseIdentifier: PurchasesViewCell.reuseId)
        historyView.tableView.register(MonthViewCell.self, forCellReuseIdentifier: MonthViewCell.reuseId)
        historyView.tableView.register(EmptyViewCell.self, forCellReuseIdentifier: EmptyViewCell.reuseId)
    }
    
    @objc private func backButtonTapped() {
        router?.dismissHistoryScreen()
    }
    
    @objc private func receivePurchase(_ notification: Notification) {
        historyView.tableView.reloadData()
        historyView.updateTableHeight()
    }
    
    @objc private func clearPurchaseHistory(_ notification: Notification) {
        TotalData.purchases = []
        historyView.tableView.reloadData()
        historyView.updateTableHeight()
    }
}
