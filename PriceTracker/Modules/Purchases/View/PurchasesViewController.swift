//
//  PurchasesViewController.swift
//  PriceTracker
//
//  Created by dread on 25.12.2024.
//

import UIKit

final class PurchasesViewController: UIViewController {
    let purchasesView = PurchasesView()
    var router: PurchasesRouterProtocol?
    
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
    
    @objc private func showHistory() {
        router?.presentHistoryScreen()
    }
}
