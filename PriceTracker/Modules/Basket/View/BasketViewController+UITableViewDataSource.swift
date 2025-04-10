//
//  BasketViewController+UITableViewDataSource.swift
//  PriceTracker
//
//  Created by dread on 14.01.2025.
//

import Foundation
import UIKit

extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let shop = tableToShop[tableView] else { return 1 }
        
        let products = productsByShop[shop] ?? [:]
        
        return products.isEmpty ? 1 : products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let shop = tableToShop[tableView] {
            let products = productsByShop[shop] ?? [:]
            if products.isEmpty {
                let cell = tableView.dequeueReusableCell(withIdentifier: EmptyViewCell.reuseId, for: indexPath)
                guard let emptyCell = cell as? EmptyViewCell else { return cell }
                emptyCell.configure("В корзине нет товаров")
                return emptyCell
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketViewCell.reuseId, for: indexPath)
        guard let basketViewCell = cell as? BasketViewCell else { return cell }
        
        guard let shop = tableToShop[tableView] else { return cell }
        guard let products = productsByShop[shop] else { return cell }
        let productKeys = Array(products.keys)
        
        if let product = productKeys[indexPath.row] {
            let formattedPrice = interactor?.multiplyPriceString(product.price, by: products[product] ?? 0)
            if let oldPriceNice = product.oldPrice {
                let formattedOldPrice = interactor?.multiplyPriceString(oldPriceNice, by: products[product] ?? 0)
                basketViewCell.configure(product, products[product] ?? 0, formattedPrice ?? "", formattedOldPrice ?? "")
            } else {
                basketViewCell.configure(product, products[product] ?? 0, formattedPrice ?? "", nil)
            }
        }
        basketViewCell.delegate = self
        return basketViewCell
    }
}
