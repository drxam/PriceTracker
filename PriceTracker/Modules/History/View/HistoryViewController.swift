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
    
    private func configure() {
        historyView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        historyView.tableView.delegate = self
        historyView.tableView.dataSource = self
        historyView.tableView.register(PurchasesViewCell.self, forCellReuseIdentifier: PurchasesViewCell.reuseId)
        historyView.tableView.register(MonthViewCell.self, forCellReuseIdentifier: MonthViewCell.reuseId)
    }
    
    @objc private func backButtonTapped() {
        router?.dismissHistoryScreen()
    }
}
