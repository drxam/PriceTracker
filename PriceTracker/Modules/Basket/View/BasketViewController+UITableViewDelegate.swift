//
//  BasketViewController+UITableViewDelegate.swift
//  PriceTracker
//
//  Created by dread on 14.01.2025.
//

import Foundation
import UIKit

extension BasketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let shop = tableToShop[tableView] else { return }
        guard let products = productsByShop[shop] else { return }
        if products.isEmpty { return }
        let productKeys = Array(products.keys)
        if let product = productKeys[indexPath.row] {
            router?.showProductScreen(product)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let shop = tableToShop[tableView] {
            let products = productsByShop[shop] ?? [:]
            if products.isEmpty {
                return 96
            }
        }
        return 96
    }
}
